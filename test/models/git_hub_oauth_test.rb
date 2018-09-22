require 'test_helper'

class GitHubOauthTest < ActiveSupport::TestCase

  before(:each) do
    @repo = 12345
    @user = 'example-user'
    @oauth_token = 'oauth-token-123'

    @hook_url = 'http://example.com/hook'

    @owner = create(:user, oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_repo: @repo, owner: @owner)
    @project_owner = mock('owner')
    @project_owner.stubs(oauth: @oauth_token)
    @project.stubs(owner: @project_owner)
    @api = mock('api')
    @api.stubs(users: stub('get', get: @user))
    Github.stubs(new: @api)
  end

  test '#new should set a project in GitHubOauth.new' do
    gho = GitHubOauth.new(@project)
    gho.project.must_equal @project
  end

  test 'github_url' do
    gho = GitHubOauth.new(@project)
    gho.github_url.must_equal "https://github.com/#{@user}/#{@repo}"
  end

  test 'installed? returns false' do
    @project_owner.stubs(github_connected?: false)
    gho = GitHubOauth.new(@project)
    refute gho.installed?
  end

  test '#user should return the GitHub user from project-url' do
    gho = GitHubOauth.new(@project)
    gho.user.must_equal @user
  end

  test '#repo should return the GitHub repo from project-url' do
    gho = GitHubOauth.new(@project)
    gho.repo.must_equal @repo
  end


  describe '#webhook_installed?' do
    it 'returns false bc GitHub is not connected' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: false)
        @hooks.expects(:all).never

        gho = GitHubOauth.new(@project)
        result = gho.webhook_installed?

        expect(result).must_equal false
      end
    end

    it '#webhook_installed? returns false because the webhook is not installed' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: true)

        @hooks.expects(:all).once.with(@user, @repo).returns(hooks_list_not_installed)

        gho = GitHubOauth.new(@project)
        refute gho.webhook_installed?
      end
    end

    it '#webhook_installed? returns true bc hook is already installed' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: true)

        @hooks.expects(:all).once.with(@user, @repo).returns(hooks_list_installed)

        gho = GitHubOauth.new(@project)
        assert gho.webhook_installed?
      end
    end
  end

  describe '#install_webhook!' do
    before(:each) do
      @hooks = mock('hooks')
      @api.stubs(repos: stub('repos', hooks: @hooks))
    end
    it 'installs the webhook' do
      @project_owner.stubs(github_connected?: true)

      @install_webhook_response = mock('install_webhook_response')
      @hooks.expects(:create).with(@user, @repo, new_hook).returns(@install_webhook_response)

      github_oauth_env(@hook_url) do
        gho = GitHubOauth.new(@project)
        expect(gho.install_webhook!).must_equal @install_webhook_response
      end
    end
  end

  def hooks_list_installed
    [bad_hook, their_hook, our_hook, their_hook, bad_hook]
  end

  def hooks_list_not_installed
    [bad_hook, their_hook, bad_hook, their_hook]
  end

  def bad_hook
    stub('bad_hook', config: stub('config', url: @hook_url, content_type: 'not-json'))
  end

  def their_hook
    stub('their_hook', config: stub('config', url: 'http://someother.com/hook', content_type: 'json'))
  end

  def our_hook
    stub('our_hook', config: stub('config', url: @hook_url, content_type: 'json'))
    # mock('hook_ours').expects(:config).twice.returns(config)
  end

  def new_hook
    {
        name: "web",
        active: true,
        config: {
            url: @hook_url,
            content_type: "json"
        }
    }
  end

end
require 'test_helper'

class GitHubOauthTest < ActiveSupport::TestCase

  before(:each) do
    @repo        = 'example-repo'
    @user        = 'example-user'
    @github_url  = "https://github.com/#{@user}/#{@repo}"
    @oauth_token = 'oauth-token-123'

    @hook_url = 'http://example.com/hook'

    @owner   = create(:user, oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_url: @github_url, owner: @owner)
  end

  test '#new should set a project in GitHubOauth.new' do
    gho = GitHubOauth.new(@project)
    gho.project.must_equal @project
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
    before do
      @hooks = mock('hooks')
      Github.stubs(new: stub('api', repos: stub('repos', hooks: @hooks)))
    end
    it 'returns false bc GitHub is not connected' do
      github_oauth_env(@hook_url) do
        @project.stubs(github_installed?: false)

        @hooks.expects(:all).never
        # @repos.expects(:hooks).returns(all)
        # @api.expects(:repos)
        # Github.expects(:new)

        gho    = GitHubOauth.new(@project)
        result = gho.webhook_installed?

        expect(result).must_equal false
      end
    end

    it '#webhook_installed? returns false because the webhook is not installed' do
      github_oauth_env(@hook_url) do
        @project.stubs(github_installed?: true)

        @hooks.expects(:all).once
            .with(@user, @repo)
            .returns(hooks_list_not_installed)
        # Github.stubs(new: mock('api', repos: mock('repos', hooks: all)))

        gho    = GitHubOauth.new(@project)
        result = gho.webhook_installed?

        expect(result).must_equal false
      end
    end

    it 'returns true bc hook is already installed' do
      github_oauth_env(@hook_url) do
        @project.stubs(github_installed?: true)

        @hooks.expects(:all).once
            .with(@user, @repo)
            .returns(hooks_list_installed)

        gho    = GitHubOauth.new(@project)
        result = gho.webhook_installed?

        expect(result).must_equal true
      end
    end
  end

  describe '#install_webhook!' do
    before(:each) do
      @hooks = mock('hooks')
      Github.stubs(new: stub('api', repos: stub('repos', hooks: @hooks)))
    end
    it 'installs the webhook' do
      @project.stubs(github_installed?: true)

      @install_webhook_response = mock('install_webhook_response')
      @hooks.expects(:create)
            .with(@user, @repo, new_hook)
            .returns(@install_webhook_response)

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
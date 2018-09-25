require 'test_helper'

class GitHubRepoTest < ActiveSupport::TestCase

  before(:each) do
    @repo_name = 'example_repo_name'
    @repo_id = 12345
    @username = 'example-user'
    @oauth_token = 'oauth-token-123'

    @hook_url = 'http://example.com/hook'

    @owner = create(:user, oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_repo: @repo_id, owner: @owner)
    # @project = mock('project')
    # @project_owner = mock('owner')
    # @project_owner.stubs(oauth: @oauth_token)
    # @project.stubs(owner: @project_owner)
    # @project.stubs(github_repo: @repo_id)
    @api = mock('api')
    @api.stubs(users: stub('get', get: @username))
    Github.stubs(new: @api)
  end

  test '#new' do
    Github.expects(:new).with(oauth_token: @oauth_token).returns(@api)
    gho = GitHubRepo.new(@project)
    gho.project.must_equal @api
  end

  test 'url' do
    gho = GitHubRepo.new(@project)
    gho.url.must_equal "https://github.com/#{@username}/#{@repo_name}"
  end

  describe 'stub repo_name for id' do
    setup do
      @repo_name = stub('repo_name', @repo_name)
      @api.stubs(repos: stub('repos', get_by_id: @repo_name))
    end
    test '#repository_name' do
      gho = GitHubRepo.new(@project)
      assert gho.repository_name.must_equal @repo_name
    end
  end


  describe '#webhook_installed?' do
    before(:each) do
      @project_owner = mock('owner')
      @project_owner.stubs(oauth: @oauth_token)
      @project.stubs(owner: @project_owner)
    end
    it 'returns false bc GitHub is not connected' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: false)
        @hooks.expects(:all).never

        gho = GitHubRepo.new(@project)
        result = gho.webhook_installed?

        assert result.must_equal false
      end
    end

    it '#webhook_installed? returns false because the webhook is not installed' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: true)

        @hooks.expects(:all).once.with(@username, @repo_name).returns(hooks_list_not_installed)

        gho = GitHubRepo.new(@project)
        refute gho.webhook_installed?
      end
    end

    it '#webhook_installed? returns true bc hook is already installed' do
      github_oauth_env(@hook_url) do
        @hooks = mock('hooks')
        @api.stubs(repos: stub('repos', hooks: @hooks))
        @project_owner.stubs(github_connected?: true)

        @hooks.expects(:all).once.with(@username, @repo_name).returns(hooks_list_installed)

        gho = GitHubRepo.new(@project)
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
      @hooks.expects(:create).with(@username, @repo, new_hook).returns(@install_webhook_response)

      github_oauth_env(@hook_url) do
        gho = GitHubRepo.new(@project)
        assert gho.install_webhook!.must_equal @install_webhook_response
      end
    end
  end

  def stub_project
    @project_owner = mock('owner')
    @project_owner.stubs(oauth: @oauth_token)
    @project.stubs(owner: @project_owner)
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

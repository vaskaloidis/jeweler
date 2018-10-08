require 'test_helper'

class GitHubUserTest < ActiveSupport::TestCase

  before(:each) do
    @repo_id = 12345
    @user = 'example-user'
    @oauth_token = 'oauth-token-123'
    @hook_url = 'http://example.com/hook'
    @owner = create(:user, github_oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_repo_id: @repo_id, owner: @owner)
    GitHubApp.stubs(:valid_auth?).returns(true)
  end

  test '#user_configured? returns true' do
    gho = GitHubUser.new(@owner)
    assert gho.user_configured?
  end

  test '#user_configured? returns false' do
    user = mock('user')
               user.stubs(:github_oauth).returns(nil)
    ghu = GitHubUser.new(user)
    refute ghu.user_configured?
    user = mock('user')
               user.stubs(:github_oauth).returns('')
    ghu = GitHubUser.new(user)
    refute ghu.user_configured?
  end

  test '#username' do
    username = 'vaskaloidis'
    api = mock('git_hub_oauth')
              api.stubs(:username).returns(username)
    GitHubOauth.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    gho.username.must_equal username
  end

  test '#avatar' do
    avatar_url = 'www.github.com/example/avatar.jpg'
    api = mock('avatar')
              api.stubs(:avatar).returns(avatar_url)
    GitHubOauth.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    assert_equal avatar_url, gho.avatar
  end

  test '#repositories' do
    # repo_list2 = [mock('repo'), mock('repo'), mock('repo')]
    repo_list = ['repo1', 'repo2', 'repo3']
    api = mock('git_hub_oauth')
              api.stubs(:repos).returns(repo_list)
    GitHubOauth.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    assert_equal repo_list, gho.repositories
  end

  describe '#install_webhooks!' do

    setup do
      @webhook = mock('webhook')
      @webhook.stubs(:install!)
      @github = stub('github', webhook: @webhook)
      @wip = stub('project', github: @github)
      @webhook_install_projects = [@wip, @wip, @wip]
      @webhook_user = create :user, github_oauth: 'github-token-123'
      @webhook_user.stubs(:owner_projects).returns(@webhook_install_projects)
    end

    test '#uninstall_webhooks!!' do
      @webhook.expects(:install!).times(3)

      gho = GitHubUser.new(@webhook_user)
      gho.install_webhooks!
    end


  end

  test '#install!' do
    owner = create :user, github_oauth: nil
    new_token = 'new-token-ght1234'

    owner.reload
    gho = GitHubUser.new(owner)
    gho.install!(new_token)
    assert_equal new_token, owner.github_oauth
  end

  describe '#uninstall!' do
    setup do
      @github = mock('github')
      @github.stubs(:uninstall!)
      @installed_project = stub('project', github: @github)
      @projects = [@installed_project, @installed_project, @installed_project]
      @installed_user = create :user, github_oauth: 'github-token-123'
      @installed_user.stubs(:owner_projects).returns(@projects)
      GitHubApp.stubs(:delete_auth!)
    end

    test '#uninstall!' do
      @github.expects(:uninstall!).times(3)
      GitHubApp.expects(:delete_auth!) #.with(token)

      @installed_user.reload
      gho = GitHubUser.new(@installed_user)
      gho.uninstall!
      @installed_user.reload
      assert_nil @installed_user.github_oauth
    end

  end

  test '#api' do
    api = create :git_hub_oauth
    GitHubOauth.stubs(new: api)

    ghu = GitHubUser.new(@owner)
    assert_equal api, ghu.api
  end

end

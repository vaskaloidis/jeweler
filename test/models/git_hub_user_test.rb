require 'test_helper'

class GitHubUserTest < ActiveSupport::TestCase

  before(:each) do
    @repo_id = 12345
    @user = 'example-user'
    @oauth_token = 'oauth-token-123'
    @hook_url = 'http://example.com/hook'
    @owner = create(:user, github_oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_repo_id: @repo_id, owner: @owner)
    GitHubApp.stubs(valid_auth?: true)
  end

  test '#user_configured? returns true' do
    gho = GitHubUser.new(@owner)
    assert gho.user_configured?
  end

  test '#user_configured? returns false' do
    user = mock('user').stubs(github_oauth: nil)
    gho = GitHubUser.new(user)
    refute gho.user_configured?
  end

  test '#username' do
    username = 'vaskaloidis'
    api = build(:github_api, github_username: username)
    Github.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    gho.username.must_equal username
  end

  test '#avatar' do
    avatar_url = 'www.github.com/example/avatar.jpg'
    api = build(:github_api, avatar_url: avatar_url)
    Github.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    gho.avatar.must_equal avatar_url
  end

  test '#repositories' do
    # repo_list2 = [mock('repo'), mock('repo'), mock('repo')]
    repo_list = ['repo1', 'repo2', 'repo3']
    api = build(:github_api, repositories: 'vaskaloidis')
    Github.stubs(:new).returns(api)

    gho = GitHubUser.new(@owner)
    assert_equal repo_list, gho.repositories
  end

  test '#install_webhooks!' do
    skip 'incomplete test'
  end

  test '#install!' do
    owner = create :user, github_oauth: nil
    new_token 'new-token-ght1234'

    owner.reload
    gho = GitHubUser.new(owner)
    gho.install!(new_token)
    assert_equal new_token, owner.github_oauth
  end

  context '#uninstall!' do
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
      # @github.expects(:uninstall!)
      # GitHubApp.expects(:delete_auth!) #.with(token)

      @installed_user.reload
      gho = GitHubUser.new(@installed_userv)
      gho.uninstall!(new_token)
      @installed_user.reload

      @installed_user owner.github_oauth
    end

  end

  test '#valid_token? is false' do
    GitHubApp.stubs(new: stub('app', valid_token?: false))
    gho = GitHubUser.new(@owner)
    refute gho.valid_token?
  end

  test '#api' do
    gho = GitHubUser.new(@owner)
    gho.api.must_equal @api
  end

end

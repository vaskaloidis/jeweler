require 'test_helper'

class GitHubUserTest < ActiveSupport::TestCase

  before(:each) do
    @repo = 12345
    @user = 'example-user'
    @oauth_token = 'oauth-token-123'

    @hook_url = 'http://example.com/hook'

    @owner = create(:user, oauth: @oauth_token)
    @project = create(:project, :seed_tasks_notes, :seed_project_users, github_repo: @repo, owner: @owner)
    # @project_owner = mock('owner')
    # @project_owner.stubs(oauth: @oauth_token)
    # @project.stubs(owner: @project_owner)
    @api = mock('api')
    @api.stubs(users: stub('get', get: @user))
    Github.stubs(new: @api)
    GitHubApp.stubs(new: stub('app', valid_token?: true))
  end

  test '#new' do
    gho = GitHubUser.new(@owner)
    gho.project.must_equal @project
  end

  test 'installed? returns true' do
    gho = GitHubUser.new(@owner)
    assert gho.installed?
  end

  test 'installed? returns false' do
    @project.stubs(owner: stub('owner', oauth: nil))
    gho = GitHubUser.new(@owner)
    refute gho.installed?
  end

  test '#username' do
    username = 'github_username'
    @api.stubs(users: stub('users', get: username))
    gho = GitHubUser.new(@owner)
    gho.username.must_equal username
  end

  test '#repositories' do
    repo_list = [mock('repo'), mock('repo'), mock('repo')]
    @api.stubs(repos: stub('repo-list', list: repo_list))
    gho = GitHubUser.new(@owner)
    assert_equal repo_list, gho.repositories
  end

  test '#valid_token? is true' do
    GitHubApp.stubs(new: stub('app', valid_token?: true))
    gho = GitHubUser.new(@owner)
    assert gho.valid_token?
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

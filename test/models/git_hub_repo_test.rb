require 'test_helper'

class GitHubRepoTest < ActiveSupport::TestCase

  before(:each) do
    @repo_id = 12345
    @user = 'example-user'
    @oauth_token = 'oauth-token-123'
    @hook_url = 'http://example.com/hook'
    @owner = create(:user, github_oauth: @oauth_token)
    @project = create(:project, github_repo_id: @repo_id, owner: @owner)
    GitHubApp.stubs(:valid_auth?).returns(true)
  end

  test '#new' do
    assert GitHubRepo.new(@project)
  end

  test '#configured? returns true' do
    ghr = GitHubRepo.new(@project)
    assert ghr.configured?
  end

  test '#configured? returns true b/c user not configured' do
    user = create :user, github_oauth: nil
    p = create(:project, github_repo_id: 12345, owner: user)
    ghr = GitHubRepo.new(p)
    refute ghr.configured?
  end

  test '#configured? returns false b/c project not configured' do
    user = create :user, github_oauth: 'github_oauth_123'
    p = create(:project, github_repo_id: nil, owner: user)
    ghr = GitHubRepo.new(p)
    refute ghr.configured?
  end

  test 'name' do
    repo_name = 'repository_name'
    api = mock('git_hub_oauth')
    api.stubs(:repository).returns(stub('repo_name', name: repo_name))
    GitHubOauth.stubs(:new).returns(api)

    gho = GitHubRepo.new(@project)
    assert_equal repo_name, gho.name
  end


  test 'url' do
    repo_name = 'repository_name'
    username = 'vaskaloidis'
    api = mock('git_hub_oauth')
    api.stubs(:username).returns(username)
    api.stubs(:repository).returns(stub('repo_name', name: repo_name))
    GitHubOauth.stubs(:new).returns(api)

    gho = GitHubRepo.new(@project)
    assert_equal "https://github.com/#{username}/#{repo_name}", gho.url
  end

  test '#webhook' do
    api = mock('webhook_api')
    GitHubWebhook.stubs(:new).returns(api)

    ghr = GitHubRepo.new(@project)
    assert_equal api, ghr.webhook
  end

  test '#uninstall! a configured webhook' do
    api = mock('webhook_api')
    api.stubs(:installed?).returns(true)
    api.stubs(:uninstall!)
    api.expects(:uninstall!)
    GitHubWebhook.stubs(:new).returns(api)

    ghr = GitHubRepo.new(@project)
    ghr.uninstall!
    @project.reload
    assert_nil @project.github_repo_id
  end

  test '#uninstall! an unconfigured webhook' do
    api = mock('webhook_api')
    api.stubs(:installed?).returns(false)
    api.stubs(:uninstall!)
    api.expects(:uninstall!).never
    GitHubWebhook.stubs(:new).returns(api)

    ghr = GitHubRepo.new(@project)
    ghr.uninstall!
    @project.reload
    assert_nil @project.github_repo_id
  end


end

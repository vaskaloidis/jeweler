require 'test_helper'

class GitHubWebhookTest < ActiveSupport::TestCase
  around do |tests|
    @hook_url = 'http://example.com/hook'
    github_push_hook_env(@hook_url) do
      @repo_id = 12345
      @user = 'example-user'
      @oauth_token = 'oauth-token-123'
      @owner = create(:user, github_oauth: @oauth_token)
      GitHubApp.stubs(:valid_auth?).returns(true)
      tests.call
    end
  end

  test '#new' do
    project = create(:project, github_repo_id: 1234, owner: @owner)
    ghr = GitHubRepo.new(project)
    assert GitHubWebhook.new(ghr)
  end

  test '#install!' do
    webhook_id = 1234
    api_hook = mock('api')
    result = {id: webhook_id}
    api_hook.stubs(:create_hook)
    api_hook.expects(:create_hook).returns(result)
    project = create(:project, github_repo_id: 'repo_id_12', github_webhook_id: nil, owner: @owner)
    ghr = GitHubRepo.new(project)
    ghr.stubs(:api).returns(api_hook)
    ghr.stubs(:name).returns('repo_name')

    ghw = GitHubWebhook.new(ghr)
    ghw.install!
    project.reload
    assert_equal webhook_id, project.github_webhook_id
  end

  test 'installed? returns true' do
    project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: 123, owner: @owner)
    ghr = GitHubRepo.new(project)
    ghw = GitHubWebhook.new(ghr)
    assert ghw.installed?
  end

  test 'installed? returns false' do
    project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: nil, owner: @owner)
    ghr = GitHubRepo.new(project)
    ghw = GitHubWebhook.new(ghr)
    refute ghw.installed?
  end


  test 'uninstall!' do
    api_hook = mock('api')
    api_hook.stubs(:delete_hook)
    api_hook.expects(:delete_hook)
    project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: 123, owner: @owner)
    ghr = GitHubRepo.new(project)
    ghr.stubs(:api).returns(api_hook)
    ghr.stubs(:name).returns('repo_name')

    ghw = GitHubWebhook.new(ghr)
    ghw.uninstall!
    project.reload
    assert_nil project.github_webhook_id
  end

end

require 'test_helper'

class GitHubWebhookTest < ActiveSupport::TestCase

  baround do |tests|
    @hook_url = 'http://example.com/hook'
    github_push_hook_env(@hook_url) do
      @repo_id = 12345
      @user = 'example-user'
      @oauth_token = 'oauth-token-123'
      @owner = create(:user, github_oauth: @oauth_token)
      @project = create(:project, github_repo_id: @repo_id, owner: @owner)
      GitHubApp.stubs(:valid_auth?).returns(true)
      tests.call
    end
  end

  test '#new' do
    ghu = GitHubUser.new(@project)
    assert GitHubWebhook.new(ghu)
  end

  def api_hook
    mock('api')
  end

  def stub_create_hook(hook_id)
    result = { id: hook_id}
    api_hook.stubs(:create_hook).returns(result)
    api_hook.expects(:create_hook)
    api_hook
  end

  def stub_delete_hook
    api_hook.stubs(:delete_hook)
    api_hook.expects(:delete_hook)
    api_hook
  end

  test '#install!' do
    webhook_id = 1234
    ghu = GitHubUser.new(@project)
    ghu.stubs(:api).returns(stub_create_hook(webhook_id))
    ghw = GitHubWebhook.new(ghu)
    ghw.install!
    @project.reload!
    assert_equal webhook_id, @project.github_webhook_id
  end

  test 'installed? returns true' do
    installed_project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: 123, owner: @owner)
    ghu = GitHubUser.new(installed_project)
    ghw = GitHubWebhook.new(ghu)
    assert ghw.installed?
  end

  test 'installed? returns false' do
    uninstalled_project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: nil, owner: @owner)
    ghu = GitHubUser.new(uninstalled_project)
    ghw = GitHubWebhook.new(ghu)
    refute ghw.installed?
  end

  test 'uninstall!' do
    uninstall_project = create(:project, github_repo_id: 'repo_id-123', github_webhook_id: 123, owner: @owner)
    ghu = GitHubUser.new(uninstall_project)
    ghu.stubs(:api).returns(stub_delete_hook)
    ghw = GitHubWebhook.new(ghu)
    refute ghw.uninstall!
  end

end

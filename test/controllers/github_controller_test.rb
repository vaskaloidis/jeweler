require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # @owner = create(:owner)
    @current_user = create :user, github_oauth: nil
    sign_in @current_user
  end

  test '#authorize_account' do
    @auth_url = 'http://github.com/authorization/'
    GitHubApp.stubs(:authorization_url).returns(@auth_url)
    get authorize_github_url
    assert_redirected_to @auth_url
  end

  test 'delete_oauth' do
    github = mock('github')
    github.stubs(:uninstall!)
    github.expects(:uninstall!)
    user = mock('user')
    user.stubs(:github).returns(github)
    User.stubs(:find).returns(user)
    delete disconnect_github_url
    assert_redirected_to edit_user_registration_path
    assert_equal 'GitHub Disconnected. Webhooks Uninstalled.', flash[:notice]
  end

  describe 'stubs authorization_token' do
    before do
      @token = 'token-123'
      GitHubApp.stubs(:authorization_token).returns(@token)
    end
    test '#save_oauth' do
      get github_oauth_save_url

      @current_user.reload
      assert_equal @token, @current_user.github_oauth
      assert_redirected_to root_path
      assert_equal 'GitHub Successfully Authenticated. Webhooks installed.', flash[:notice]
    end
  end

  describe ' stubs webhook.install' do
    before do
      @webhook = mock('webhook')
      @webhook.stubs(:install!)
      @repo = mock('api')
      @repo.stubs(:webhook).returns(@webhook)
      GitHubRepo.stubs(:new).returns(@repo)
    end
    test '#install_webhook' do
      @webhook.expects(:install!).once
      project = create(:project, github_repo_id: 1234, github_webhook_id: nil)

      get install_github_webhook_url(project), xhr: true

      assert_equal 'text/javascript', @response.content_type
      assert_response :success
    end
  end

  describe ' stubs webhook.uninstall' do
    before do
      @webhook = mock('webhook')
      @webhook.stubs(:uninstall!)
      @repo = mock('api')
      @repo.stubs(:webhook).returns(@webhook)
      GitHubRepo.stubs(:new).returns(@repo)
    end
    test '#uninstall_webhook' do
      @webhook.expects(:uninstall!).once
      project = create(:project, github_repo_id: 1234, github_webhook_id: 1234)

      delete uninstall_github_webhook_url(project), xhr: true

      assert_equal 'text/javascript', @response.content_type
      assert_response :success
    end
  end

  test '#sync_commits' do
    skip 'feature not complete'
  end

  describe '#hook' do
    it 'executes the webhook' do
      skip 'feature not complete'
      payload_mock = Json.new
      # payload = JSON.parse(request.body.read)
      # commits = payload["commits"]
      assert_difference('Github.count') do
        post execute_github_webhook_url, payload_mock
      end
      assert_response :success
    end
  end

  teardown do
    sign_out @current_user
  end

end

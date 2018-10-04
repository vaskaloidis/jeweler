require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # @owner = create(:owner)
    @current_user = create :user, github_oauth: nil
    sign_in @current_user
  end

  describe '#authorize_account' do
    before do
      @auth_url = 'http://github.com/authorization/'
      @api = mock('api').stubs(:authorization_url)
      GitHubApp.stubs(:new).returns(@api)
    end
    it 'does not authorize users with GitHub already connected' do
      mock_user = stub('mock-user', github_oauth: 'oauth-code-123')
      User.stubs(:find).returns(mock_user)
      @api.expects(:authorization_url).returns(@auth_url)

      get authorize_github_url

      assert_redirected_to root_path
      flash[:notice].must_equal 'GitHub is already installed'
    end
    it 'forwards users to GitHub auth who dont have it already connected' do
      @api.expects(:authorization_url).returns(@auth_url)

      get authorize_github_url

      assert_redirected_to @auth_url
    end
  end

  describe '#save_oauth' do
    before do
      @token = 'token-123'
      @api = mock('api').stubs(:authorization_token)
      GitHubApp.stubs(:new).returns(@api)
    end
    it 'should save GitHub user Oauth Token' do
      @api.expects(:authorization_token).once.returns(@token)

      get github_oauth_save_url

      @current_user.reload
      assert_equal @token, @current_user.github_oauth
      assert_redirected_to root_path
      flash[:notice].must_equal 'GitHub Account Successfully Authenticated!'
    end
  end

  describe '#install_webhook' do
    before do
      @stub = mock('api').stubs(:install_webhook!)
      GitHubOauth.stubs(:new).returns(@stub)
    end
    it 'installs the webhook' do
      @stub.expects(:install_webhook!).once
      project = create(:project_with_github_test_repo)

      get install_github_webhook_url(project), xhr: true

      assert_equal 'text/javascript', @response.content_type
      assert_response :success
    end
  end


  describe '#hook' do
    it 'executes the webhook' do
      skip 'test not written yet'
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

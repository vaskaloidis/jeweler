require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest


  describe 'Requesting a GitHub Token' do
    it 'should redirect to GitHub authorization' do
      github_app_env('gh-client-id', 'gh-client-secret') do
        GitHubApp.stubs(:authorization_url).returns('http://test.com')
        get authorize_github_url
        assert_redirected_to 'http://test.com'
      end
    end
  end

  describe 'Saving a GitHub Token' do
    let(:current_user) {create(:user)}
    before do
      User.stubs(:find).returns(current_user)
      GitHubApp.expects(:api).returns(nil)
               .then.stubs(:get_token).returns('token123')
    end
    it 'should save GitHub user Oauth Token' do
      current_user.oauth.must_be_nil
      get github_oauth_save_url
      assert_redirected_to 'http://test.com'
      flash[:notice].must_equal 'GitHub Account Successfully Authenticated!'
    end
  end

  describe 'Install_webhook' do
    it 'takes the auth_code and makes a GitHub API call to get a token' do
      project = create(:project_with_github_test_repo)
      get install_github_webhook_url(project), xhr: true
      assert_response :success
      gho = GitHubOauth.new(project)
      assert gho.webhook_installed?
    end
  end


  test "should get a GitHub Push Event" do
    payload_mock = Json.new
    # payload = JSON.parse(request.body.read)
    # commits = payload["commits"]
    assert_difference('Github.count') do
      post execute_github_webhook_url, payload_mock
    end
    assert_response :success
  end

end

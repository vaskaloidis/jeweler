require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "should get a GitHub Push Event" do
    skip 'TODO: Mock Push Event Payload'
    payload_mock = Json.new
    # payload = JSON.parse(request.body.read)
    # commits = payload["commits"]
    assert_difference('Github.count') do
      post execute_github_webhook_url, payload_mock
    end
    assert_response :success
  end

  test "should save GitHub user Oauth Token" do
    skip 'TODO: Mock GitHub OAuth token'
    get github_oauth_save_url
    assert_response :success
  end

  test "should redirect to GitHub authorization " do
    get authorize_github_url
    assert_redirected_to GitHubApp.authorization_url
  end

  test "should show github" do
    skip 'test stub not created yet'
    project = create(:project_with_github_test_repo)
    get install_github_webhook_url(project), xhr: true
    assert_response :success
    gho = GitHubOauth.new(project)
    assert gho.webhook_installed?
  end
end

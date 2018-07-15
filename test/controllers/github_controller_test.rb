require 'test_helper'

class GithubControllerTest < ActionDispatch::IntegrationTest


  describe 'Requesting a GitHub Token' do
    let(:request_path) {"/authorizations/1"}
    let(:host) {"https://api.github.com"}
    let(:body) {fixture('auths/authorization.json')}
    let(:status) {201}
    before do
      stub_put(request_path, host).to_return(body: body,
                                             status: 201,
                                             headers: {content_type: "application/json; charset=utf-8"})
    end

    it "should redirect to GitHub authorization " do
      # skip 'test not finished'
      gh_app_envs do
        get authorize_github_url
        assert_redirected_to GitHubApp.authorization_url
        a_post(request_path, host).with(body: inputs).should have_been_made
      end
    end
  end

  describe 'Saving a GitHub Token' do
    let(:request_path) {"/authorizations/1"}
    let(:host) {"https://api.github.com"}
    let(:body) {fixture('auths/authorization.json')}

    before do
      stub_put(request_path, host).to_return(body: body,
                                             status: 201,
                                             headers: {content_type: 'application/json; charset=utf-8'})
    end

    it "should save GitHub user Oauth Token" do
      skip 'TODO: Mock GitHub OAuth token'
      get github_oauth_save_url
      a_patch(request_path, host).with(body: inputs).should have_been_made
      assert_response :success
    end

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


  test "should show github" do
    skip 'test stub not created yet'
    project = create(:project_with_github_test_repo)
    get install_github_webhook_url(project), xhr: true
    assert_response :success
    gho = GitHubOauth.new(project)
    assert gho.webhook_installed?
  end
end

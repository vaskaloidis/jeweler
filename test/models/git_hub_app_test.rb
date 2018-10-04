require 'test_helper'
require 'mocha/test_unit'

class GitHubAppTest < ActiveSupport::TestCase

  around do |tests|
    @client_id     = 'client-id-123'
    @client_secret = 'client-secret-123'

    github_app_env(@client_id, @client_secret) do
      @api_result = mock('api_result')

      # Github.stubs(:new)
      Github.expects(:new).once
            .with(:client_id => @client_id, :client_secret => @client_secret)
          .returns(@api_result)

      tests.call
    end
  end

  describe '#authorize_url' do
    it 'should return the authorization url' do
      @auth_url = 'https://api.github.com/login/oauth/authorize'
      @scope    = 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'

      @api_result.expects(:authorize_url).once.with(scope: @scope).returns(@auth_url)

      assert_equal GitHubApp.authorization_url, @auth_url
    end
  end

  describe '#authorization_token' do
    it 'takes an auth_code and returns a token' do
      token     = 'token-123'
      auth_code = 'authcode-123'

      token_response = mock('token_response', token: token)
      @api_result.expects(:get_token).once.with(auth_code).returns(token_response)

      assert_equal GitHubApp.authorization_token(auth_code), token
    end
  end
end




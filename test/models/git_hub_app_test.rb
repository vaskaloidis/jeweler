require 'test_helper'
require 'mocha/test_unit'

class GitHubAppTest < ActiveSupport::TestCase

  around do |tests|
    @client_id = 'client-id-123'
    @client_secret = 'client-secret-123'

    github_app_env(@client_id, @client_secret) do
      tests.call
    end
  end

  describe 'Github App API' do
    setup do
      @api_result = mock('api_result')
      Github.expects(:new).once
          .with(:client_id => @client_id, :client_secret => @client_secret)
          .returns(@api_result)
    end
    test '#authorize_url' do
      @auth_url = 'https://api.github.com/login/oauth/authorize'
      @scope = 'repo admin:repo_hook read:user'

      @api_result.expects(:authorize_url).once.with(scope: @scope).returns(@auth_url)

      assert_equal GitHubApp.authorization_url, @auth_url
    end

    test '#authorization_token' do
      token = 'token-123'
      auth_code = 'authcode-123'

      token_response = mock('token_response', token: token)
      @api_result.expects(:get_token).once.with(auth_code).returns(token_response)

      assert_equal GitHubApp.authorization_token(auth_code), token
    end
  end

  test 'valid_auth?' do
    review_url = "https://github.com/settings/connections/applications/#{@client_id}"
    assert_equal GitHubApp.review_url, review_url
  end

  test 'delete_auth!' do
    basic_auth = mock('api_result')
    Github.stubs(:new).returns(basic_auth)
    token = 'auth-token-123'
    basic_auth.stubs(:delete) #.with(token)
    delete = mock('delete')
    delete.stubs(:delete)
    # delete.expects(:delete).with(@client_id, token)
    basic_auth.stubs(:oauth).returns(stub('app', app: delete))
    GitHubApp.delete_auth!(token)
  end

end




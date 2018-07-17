require 'test_helper'

class GitHubAppTest < ActiveSupport::TestCase

  around do |tests|
    @client_id = 'client-id-123'
    @client_secret = 'client-secret-123'

    github_app_env(@client_id, @client_secret) do

      @github_api = mock('github_api').responds_like(Github.new)

      @token = 'token-123'
      @auth_code = 'authcode-123'
      @github_api.stubs(:get_token).with(@auth_code).returns(@token)

      @auth_url = 'https://api.github.com/login/oauth/authorize'
      @scope = 'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'
      @github_api.stubs(:authorize_url).with(scope: @scope).returns(@auth_url)
9
      Github.stubs(:new)
          .with(:client_id => @client_id, :client_secret => @client_secret)
          .returns(@github_api)
      tests.call
    end
  end

  describe '#api' do
    it 'should return api' do
      GitHubApp.github_api.must_equal @github_api
    end
  end

  describe '#authorize_url' do
    it 'should return the authorization url' do

      GitHubApp.authorization_url.must_equal @auth_url
    end
  end

  describe '#authorization_token' do
    it 'takes an auth_code and returns a token' do

      # @github_api.stubs(:get_token).with(@auth_code).returns(@token)
      GitHubApp.authorization_token(@auth_code).must_equal @token
    end
  end
end




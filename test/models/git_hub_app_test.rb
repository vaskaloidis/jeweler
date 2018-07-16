require 'test_helper'

class GitHubAppTest < ActiveSupport::TestCase
  # around do |tests|
  #   # github_app_env(github_client_id, github_client_secret, &tests)
  # end

  let(:api) { mock().expects(:authorize_url).stubs(:get_token)}

  setup do
    Github.any_instance.stubs(:new).returns(api)
  end

  describe '#authorize_url' do
    let(:scope) {'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'}
    let(:auth_url) {'https://api.github.com/login/oauth/authorize'}
    let(:api) { mock().expects(:authorize_url).with(scope: scope).returns(auth_url)}
    it 'should return a string' do
      GitHubApp.authorization_url.must_equal auth_url
    end
  end

  describe '#authorization_token' do
    let(:token) {'token-123'}
    let(:authcode) {'authcode-123'}
    let(:api) { mock.expects(:get_token).with(authcode).returns(token)}
    it 'takes an auth_code and returns a string' do
      GitHubApp.authorization_token(auth_code).must_equal token
    end
  end
end




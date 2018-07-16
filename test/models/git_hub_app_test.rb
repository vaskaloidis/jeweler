require 'test_helper'

class GitHubAppTest < ActiveSupport::TestCase
  let(:github_client_id) {'client-id-123'}
  let(:github_client_secret) {'client-secret-123'}
  let(:auth_code) {'authcode-123'}
  let(:token) {'token-123'}

  around do |tests|
    github_app_env(github_client_id, github_client_secret, &tests)
  end

  context 'local testing' do

    before do
      mock('github').stubs(:new).with(client_id: github_client_id, client_secret: github_client_secret)
    end

    after do
      Github.verify.must_be true
    end

    describe '#authorize_url' do
      let(:scope) {'repo admin:repo_hook read:repo_hook write:repo_hook admin:org_hook'}
      let(:auth_url) {'https://api.github.com/login/oauth/authorize'}

      before do
        Github.stubs(:authorize_url).with(scope: scope).returns(auth_url)
      end

      it 'should return a string' do
        GitHubApp.authorization_url.must_be_instance_of String
      end

      after do
        Github.verify.must_be true
      end
    end

    describe '#authorization_token' do
      it 'takes an auth_code and returns a string' do
        mock('github').stubs(:get_token).with(token).returns(token)
        GitHubApp.authorization_token(auth_code).must_be_instance_of String
      end

      after do
        Github.verify.must_be true
      end
    end
  end

  context 'remote testing' do
    let(:api_url) {"https://github.com/login/oauth/access_token"}
    before do
      @api_url = "https://github.com/login/oauth/access_token"
    end
    describe '#authorization_token' do
      it 'makes an authorization request' do
        stub = stub_request(:post, @api_url).
            with(body: {"client_id" => github_client_id,
                        "client_secret" => github_client_secret,
                        "code" => auth_code,
                        "grant_type" => "authorization_code"})
        mock('github').expects(:get_token).with(:auth_code).return(@token)

        GitHubApp.authorization_token(auth_code).must_equal token
        assert_requested(stub)
      end
    end

    describe '#authorization_token' do
      before do
        # @stub = stub_request(:post, @api_url).
      end
      it 'makes an authorization request' do
        mock('github').expects(:authorize_url).returns(token)
        GitHubApp.authorization_token(auth_code).must_equal token
        # assert_requested(@stub)
      end
    end

  end

end




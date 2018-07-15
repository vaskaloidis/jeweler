require 'test_helper'

class GitHubAppTest < ActiveSupport::TestCase

  let(:github_app) {GitHubApp.new}

  let(:github_client_id) {'client-id-123'}
  let(:github_client_secret) {'client-secret-123'}

  around do |tests|
    github_app_env(github_client_id, github_client_secret, &tests)
  end

  before do
    (GitHubApp.new).stubs(:new).with(client_id: github_client_id, client_secret: github_client_secrt)
  end

  describe '#api' do
    it 'should respond to api' do
      expect(github_app).to respond_to(:api)
    end

    it 'returns the API' do
      expect(github_app.api).to eq('https://api.github.com')
    end

    it 'returns the GitHub API as an Oauth instance' do
      expect(github_app.api).must_be_instance_of OAuth2::Client
    end
  end

  describe '#authorize_url' do
    it 'should respond to authorize_url' do
      should respond_to(:authorize_url)
    end

    it "should return address containing client_id and auth url" do
      githu.authorize_url.should =~ '/login/oauth/authorize'
      github.authorize_url.should =~ "/client_id=#{github_client_id}/"
    end

    it "should return address containing scopes" do
      github.authorize_url.should =~ '/scope=repo%20admin:repo_hook%20read:repo_hook%20write:repo_hook%20admin:org_hook/'
    end
  end

end




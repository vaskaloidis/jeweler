require 'test_helper'

class GitHubOauthTest < ActiveSupport::TestCase

  around do |tests|
    @repo = 'example-repo'
    @user = 'example-user'
    @github_url = "https://github.com/#{@user}/#{repo}"
    @oauth_token = 'oauth-token-123'
    @owner = create(:user, oauth: @oauth_token)
    @project = create(:project, github_url: @github_url, owner: @owner)
    @github_oauth = GitHubOauth.new @project

    @hook_url = 'http://example.com/hook'
    github_oauth_env(@hook_url) do


      @github_api = mock('github_api')
                        .responds_like(Github.new)
                        .stubs(:repos).returns(@repos)
      tests.call
    end
  end

  describe '.new' do
    it 'should set a project in GitHubOauth.new' do
      gho = GitHubOauth.new(@project)
      gho.project.must_equal @project
      GitHubOauth.project.must_equal @project
    end
    it 'should set the project using the attr_accessor' do
      Github.stubs(:new).with(:oauth_token => @oauth_token).returns(@github_api)
      GitHubOauth.project = @project
      GitHubOauth.project.must_equal @project
      GitHubOauth.github_api.must_equal @github_api
    end
  end

  describe '.github_api' do
    it 'should initialize github api with oauth params and return it' do
      Github.expect(:new).once.with(:oauth_token => @oauth_token).returns(@github_api)
      gho = GitHubOauth.new(@project)
      gho.github_api.must_equal @github_api
      GitHubOauth.github_api.must_equal @github_api
    end
  end

  describe '.user' do
    it 'should return the GitHub user from project-url' do
      gho = GitHubOauth.new(@project)
      gho.user.must_equal @user
      GitHubOauth.user.must_equal @user
    end
  end

  describe '.repo' do
    it 'should return the GitHub repo from project-url' do
      gho = GitHubOauth.new(@project)
      gho.user.must_equal @repo
      GitHubOauth.repo.must_equal @repo
    end
  end

  describe '.hooks' do
    it 'should return the GitHub repo hooks from a user and repo' do
      Github.expect(:new).once.with(:oauth_token => @oauth_token).returns(@github_api)
      stub_hooks_ours_not_installed
      gho = GitHubOauth.new(@project)
      gho.hooks.must_equal hooks_list_without_ours
      GitHubOauth.hooks.must_equal hooks_list_without_ours
    end
  end

  describe '.install_webhook!' do
    it 'should not install the webhook because it is already installed' do
      skip 'not implemented'
      # TODO: Finish Spec
    end
    it 'should install the webhook because it is not installed' do
      skip 'not implemented'
      # TODO: Finish Spec
    end
  end

  describe '.webhook_installed' do
    it 'should return false because the webhook is not installed' do
      skip 'not implemented'
      # TODO: Finish Spec
    end
    it 'should return true because the webhook is installed' do
      skip 'not implemented'
      # TODO: Finish Spec
    end
  end


  # Helpers
  # TODO: Move these to a separate module possibly
  def stub_hooks_ours_is_installed
    @hooks_create = mock('hooks_create').with(:user, :repo, :new_hook).returns(true)
    @hooks_all = mock('hooks_all')
                     .with([:user => @user, :repo => @repo])
                     .returns(hooks_list_with_ours)
    stub_repos_hooks
  end

  def stub_hooks_ours_not_installed
    @hooks_create = mock('hooks_create').with(:user, :repo, :new_hook).returns(true)
    @hooks_all = mock('hooks_all')
                     .with([:user => @user, :repo => @repo])
                     .returns(hooks_list_without_ours)
    stub_repos_hooks
  end

  def hooks_list_with_ours
    [hook_theirs, hook_theirs, hook_ours, hook_theirs]
  end

  def hooks_list_without_ours
    [hook_theirs, hook_theirs, hook_theirs, hook_theirs]
  end

  def hook_theirs
    mock('hook')
        .stubs('config').returns(mock('config').stubs('content_type').returns('json'))
        .stubs('config_url').returns('http://their-site.com/hook')
  end

  def hook_ours
    mock('hook')
        .stubs('config').returns(mock('config').stubs('content_type').returns('json'))
        .stubs('config_url').returns(@hook_url)
  end

  def stub_repos_hooks
    @hooks = mock('hooks')
                 .expects(:all).once.returns(@hooks_all)
                 .expects(:create).once.returns(@hooks_create)
    @repos = mock('repos').stubs(:hooks).returns(@hooks)
  end

end
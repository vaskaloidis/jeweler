require 'test_helper'

class GitHubOauthTest < ActiveSupport::TestCase

  setup do
    # TODO: Use Faker for dynamic GH Username and Repo names (more use-cases)
    @project = create(:project_with_github_test_repo)
    @gho = GitHubOauth.new @project
  end


  test 'should return instance of GitHubOauth' do
    assert @gho
  end

  test 'should return GitHub username' do
    assert_equal 'vaskaloidis', @gho.gh_user
  end

  test 'should return GitHub repo name' do
    assert_equal 'jeweler_test_repo', @gho.gh_repo
  end

end
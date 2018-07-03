require 'test_helper'

class GitHubAppTest < ActiveSupport::TestCase

  setup do
    @project = create(:project, github_url: 'https://github.com/vaskaloidis/jeweler')
  end

  test 'class gets functionally instantiated' do
    skip 'Implement ENV first'
    refute GitHubApp.api.nil?
    refute GitHubApp.build.nil?
  end

  test 'authorization_url method' do
    skip 'Implement ENV first'
    refute GitHubApp.authorization_url.nil?
  end

end




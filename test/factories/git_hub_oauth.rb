FactoryBot.define do
  factory :git_hub_oauth, class: GitHubOauth do
    skip_create

    initialize_with { new(attributes) }

    ignore do
      repo_name { 'repository_name' }
    end

    token { 'oauth-token-123' }
    repos { ['repo1', 'repo2', 'repo3'] }
    username { 'github_username' }
    avatar { 'https://example.com/repo.jpg' }
    # repository { { name: repo_name } }
    # delete_hook { true }
    all_hooks { ['hook1', 'hook2', 'hook3'] }
    create_hook { true }
  end
end

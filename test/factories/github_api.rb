FactoryBot.define do
  factory :github_api, class: Github do
    skip_create

    ignore do
      github_username { 'github_username' }
      avatar_url { 'https://example.com/repo.jpg' }
      repositories { ['repo1', 'repo2', 'repo3'] }
    end

    users { { get: { login: github_username, avatar_url: avatar_url } } }
    repos { { list: repositories } }
  end
end

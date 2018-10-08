FactoryBot.define do
  factory :git_hub_user, class: GitHubUser do
    skip_create

    ignore do
      github_oauth { 'github-oauth-token-123' }
      owner { attributes_for(:user, github_oauth: github_oauth) }
      github_username { 'github-username' }
      avatar_url { 'http://avatar_url.exmaple.com/image.jpg' }
    end

    user_configured? { true }
    username { 'username' }
    avatar { 'https://avatar-url.com/image.jpg' }
    repositories { { id: 123, name: 'repository-name' } }
    valid? { true }
    install_webhooks! { true }
    install! { true }
    uninstall! { true }
    api { {
        users: { get: { login: github_username, avatar_url: avatar_url } },
        api: {  }
    } }
    log_error { true }
    auth_valid { true }

  end
end

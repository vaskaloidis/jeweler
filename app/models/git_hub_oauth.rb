class GitHubOauth
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def repos
    api.repos.list user: username
  end

  def username
    user_data.login
  end

  def avatar
    user_data.avatar_url
  end

  def repository(id)
    api.repos.get_by_id(id)
  end

  def delete_hook(name, id)
    api.repos.hooks.delete username, name, id
  end

  def all_hooks(name)
    api.repos.hooks.all(username, name)
  end

  def create_hook(name, new_webhook)
    api.repos.hooks.create(username, name, new_webhook)
  end

  private

  def user_data
    @user_data ||= api.users.get
  end

  def api
    @api ||= Github.new oauth_token: @token
  end

end

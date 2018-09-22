class GitHubUser

  def initialize(owner)
    @owner = owner
  end

  def installed?
    @owner.github_connected?
  end

  def user
    @user ||= api.users.get
  end

  def repos
    @repos ||= api.repos.list
  end

  def repo_select
    @repo_names ||= repos.collect{ |r| [r.name, r.id]}
  end

  def api
    @api ||= Github.new oauth_token: @owner.oauth
  end

end

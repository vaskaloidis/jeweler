class GitHubBase

  def user(url)
    URI(url).path.split('/').second
  end

  def repo(url)
    URI(url).path.split('/').third
  end

  def user_valid?(username)
    request = Github.new(user: username).repos.list
    return request.success?
  rescue Github::Error::NotFound
    return false
  end

end
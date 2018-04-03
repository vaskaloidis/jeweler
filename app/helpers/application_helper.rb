module ApplicationHelper

  def self.github_user(project)
    uri = URI(project.github_url)
    return uri.path.split('/').second
  end

  def self.github_repo(project)
    uri = URI(project.github_url)
    return uri.path.split('/').third
  end

end

module GithubHelper

  def repos_select(repositories)
    @repos_select ||= begin
      if repositories
        repositories.collect {|r| [r.name, r.id]}
      else
        []
      end
    end
  end

end
module ProjectsHelper

  def repos_select(repositories)
    @repos_select ||= repositories.collect {|r| [r.name, r.id]}
  end

end

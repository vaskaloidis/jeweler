class SyncGithubCommits < Jeweler::Service
  attr_reader :project, :user

  def initialize(project, user)
    @project = project
    @user = user
  end

  def call
    sync_github(project, user)
  end

  private

  def sync_github(project, user)
    return unless false # TODO: Add a setting to enable / disable Github_Sync
    return unless project.owner?(user) and !project.owner.github_oauth.nil?
    begin
      github = Github.new oauth: project.owner.oauth
      logger.debug('GitHub User: ' + project.github.username)
      logger.debug('GitHub Repo: ' + project.github.repo_name)
      repos = github.repos.commits.all project.github.username, project.github.repo_name
      repos.each do |commit|
        next unless Note.where(project: project, git_commit_id: sha).empty?
        sha = commit.sha
        note = Note.new
        note.author = project.owner
        note.note_type = 'commit'
        note.git_commit_id = sha
        note.sync = true
        note.project = project
        note.content = commit.commit.message.to_s + ' - ' + commit.commit.author.name.to_s

        unless project.current_sprint.nil?
          note.sprint = project.current_sprint
        end
        unless project.current_task.nil?
          note.task = project.current_task
        end

        note.created_at = commit.commit.committer.date
        note.save
        puts 'Note Created for Commit Sync, SHA: ' + commit.sha
      end
    rescue Exception
      logger.error("Error syncing Github Repo")
      logger.error
    end
  end
end

# GitHub WebHook Push Event endpoint
#
class PushWebhook < Jeweler::Service
  attr_reader :project

  def initialize(project)
    @project = project
  end

  # POST /github_hook
  # TODO: Move this to a delayed job
  # TODO: Make this more modular
  # Build a GitHubPushEvent Model

  def call
    push
  end

  private

  def push
    logger.info "Executing GitHub Webhook"

    payload = JSON.parse(request.body.read)
    # payload = ActiveSupport::JSON.decode(response.body)

    commits = payload["commits"]
    notes   = Array.new

    unless commits.nil?
      commits.each do |commit|

        sha = commit["id"]

        logger.debug("Commit SHA: " + sha.to_s)

        commit_message = commit["message"]

        hide_message   = false
        custom_message = false
        commands       = commit_message.split('#jeweler')

        commands.each_with_index do |command, count|
          unless count == 0
            pounds = command.split('#')
            second = pounds.second
            third  = pounds.third
            fourth = pounds.fourth

            if second.starts_with?('task')
              sprint = second
              sprint.slice! 'task'
              task = sprint.slice!(sprint.size - 1...sprint.size)

              if third == 'complete' or third == 'completed' or third == 'finished'

              elsif third == 'current'

              elsif third == 'hours'

              elsif third == 'estimate'

              elsif third == 'incomplete'

              elsif third == 'in-progress' or third == 'started'
              elsif third == 'testing'
              elsif third == 'reviewing' or third == 'review'
              end
            elsif second.starts_with?('sprint')
              sprint = second
              sprint.slice! 'sprint'
              if third == 'current'

              elsif third == 'open'

              elsif third == 'close'

              elsif third == 'request-payment'

              elsif third == 'send-invoice'

              elsif third == 'send-estimate'

              end
            elsif second == 'commit'

              if third == 'hide-message'
                hide_message = true
              elsif third == 'message'
                custom_message = fourth
              end


            end

          end
        end

        diff_url = payload["compare"]
        # message = message + '<br><a href="' + payload["compare"] + '">View Commit</a>'

        unless commit["added"].empty?
          message = message + '<br> <strong>Files Added:</strong><br>'
          commit["added"].each do |file|
            message = message + file + '<br>'
          end
        end
        unless commit["removed"].empty?
          message = message + '<br> <strong>Files Removed:</strong><br>'
          commit["removed"].each do |file|
            message = message + file + '<br>'
          end
        end
        unless commit["modified"].empty?
          message = message + '<br> <strong>Modified:</strong><br>'
          commit["modified"].each do |file|
            message = message + file + '<br>'
          end
        end

        # Head_Commit for Author Name
        # head_commit = payload["head_commit"]
        # author = head_commit["author"]
        # author_name = author["name"]

        repository = payload["repository"]
        repository_id = repository[:id]
        repo_url   = repository["html_url"]
        logger.debug("Repository URL: " + repo_url)

        @project = Project.where(github_repo_id: repository_id).first # Verify repository from payload is repo-id
        logger.debug("Project Name: " + @project.name)

        note               = Note.new
        note.author        = @project.owner
        note.note_type     = 'commit'
        note.git_commit_id = sha
        note.sync          = true
        note.project       = @project
        note.content       = message.to_s

        unless diff_url.nil? or diff_url == ''
          note.commit_diff_path = diff_url.to_s
        end
        unless @project.current_sprint.nil?
          note.sprint = @project.current_sprint
        end
        unless @project.current_task.nil?
          note.task = @project.current_task
        end

        note.save
        notes << note
      end
    end

    respond_to do |format|
      format.json { render json: notes.to_json }
    end
  end
end
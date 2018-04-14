class WebhookController < ApplicationController
  # protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  # protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_action :verify_authenticity_token

  respond_to :json, :html

  def hook
    logger.debug "GitHub Webhook Executed!"
    payload = JSON.parse(request.body.read)
    # payload = ActiveSupport::JSON.decode(response.body)

    commits = payload["commits"]
    notes = Array.new

    unless commits.nil?
      commits.each do |commit|

        logger.debug("Iterating over commit")

        sha = commit["id"]

        logger.debug("Commit SHA: " + sha.to_s)

        message = commit["message"]

        diff_url = payload["compare"]
        # message = message + '<br><a href="' + payload["compare"] + '">View Commit</a>'

        unless commit["added"].empty?
          message = message + '<br> <strong>Added:</strong><br>'
          commit["added"].each do |file|
            message = message + file + '<br>'
          end
        end
        unless commit["removed"].empty?
          message = message + '<br> <strong>Removed:</strong><br>'
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
        repo_url = repository["html_url"]
        logger.debug("Repository URL: " + repo_url)

        @project = Project.where(github_url: repo_url).first
        logger.debug("Project Name: " + @project.name)

        note = Note.new
        note.author = @project.owner
        note.note_type = 'commit'
        note.git_commit_id = sha
        note.sync = true
        note.project = @project
        note.content = message.to_s

        unless diff_url.nil? or diff_url == ''
          note.commit_diff_path = diff_url.to_s
        end
        unless @project.current_sprint.nil?
          note.invoice = @project.current_sprint
        end
        unless @project.current_task.nil?
          note.invoice_item = @project.current_task
        end

        note.save
        notes << note
      end
    end

    respond_to do |format|
      format.json {render json: notes.to_json}
    end

  end

  def configure_webhook
    user = User.find(params[:user_id])
    token = user.oauth

    gh = Github.new oauth: token

    github = Github.new oauth: project.owner.oauth
    logger.debug('GitHub User: ' + ApplicationHelper.github_user(project))
    logger.debug('GitHub Repo: ' + ApplicationHelper.github_repo(project))
    repos = github.repos.commits.all ApplicationHelper.github_user(project), ApplicationHelper.github_repo(project)

  end

  def save_oath
    token = params[:code]

    puts 'Save Oath Token: ' + token.to_s

    user = User.find(current_user.id)
    user.oauth = token

    respond_to do |format|
      if user.save!
        format.html {redirect_to root_path, notice: 'GitHub Account Successfully Authenticated!'}
      else
        format.html {redirect_to root_path, :flash => {:error => 'Error Authenticated GitHub Authenticated.'}}
      end
    end
  end

  def authorize_account
    github = Github.new client_id: ENV['GITHUB_CLIENT_ID'], client_secret: ENV['GITHUB_CLIENT_SECRET']
    github.authorize_url scope: 'repo admin:repo_hook write:repo_hook read:repo_hook admin:org_hook notifications'

    logger.debug("Github Auth URL: " + github.authorize_url)

    respond_to do |format|
      format.html { redirect_to github.authorize_url }
    end

  end


  private
  def save_webhook_params(params)
    @params = params

    #slice and dice
    webhook_id = @params[:webhook_id]
    puts "WEBHOOK ID #{webhook_id}"

    from = @params[:message_data][:addresses][:from][:email]
    puts "FROM #{from}"

    to = @params[:message_data][:addresses][:to][0][:email]
    puts "TO #{to}"

    body = @params[:message_data][:bodies][0][:content]
    puts "BODY #{body}"

    received = @params[:message_data][:date_received]
    date_format = Time.at(received).to_datetime
    puts "DATE #{date_format}"

  end
end

class NotesController < ApplicationController
  before_action :set_project, only: [:index]
  before_action :set_note, only: [:edit, :update, :destroy]

  def note_query
    @project = Project.find(params[:project_id])
    @note_type = params[:note_type].downcase
    @sprint_query = params[:sprint_query]

    logger.debug("Note Type Query: " + @note_type)
    logger.debug("Sprint Query: " + @sprint_query)

    if @sprint_query == 'all'
      @sprint = @project.notes
    else
      @sprint = @project.get_sprint(@sprint_query).notes
    end

    if @note_type == 'all'
      @notes = @sprint.order('created_at DESC').all
    else
      case @note_type
        when 'commit'
          @notes = @sprint.where(note_type: :commit).order('created_at DESC').all
        when 'note'
          @notes = @sprint.where(note_type: :note).order('created_at DESC').all
        when 'project_update'
          @notes = @sprint.where(note_type: :project_update).order('created_at DESC').all
        when 'demo'
          @notes = @sprint.where(note_type: :demo).order('created_at DESC').all
        when 'payment'
          @notes = @sprint.where(note_type: :payment).order('created_at DESC').all
        when 'payment_request'
          @notes = @sprint.where(note_type: :payment_request).order('created_at DESC').all
        when 'task'
          @notes = @sprint.where(note_type: :task).order('created_at DESC').all
        when 'event'
          @notes = @sprint.where(note_type: :event).order('created_at DESC').all
        else
          @notes = @sprint.all
      end
    end

    @query = @note_type
    respond_to do |format|
      format.js
    end
  end

  def new
    @note = Note.new
    @note.author = current_user
    @note.project = Project.find(params[:project_id])
    @note.note_type = 'note'

    unless @note.project.current_sprint.nil?
      @note.sprint = @note.project.current_sprint
    end

    unless @note.project.current_task.nil?
      @note.task = @note.project.current_task
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /notes/1/edit
  def edit; end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.author = current_user

    project = @note.project
    unless project.current_sprint.nil?
      @note.sprint = project.current_sprint
    end

    unless project.current_task.nil?
      @note.task = project.current_task
    end

    if @note.note_type == 'demo'
      uploader = AvatarUploader.new
      require 'screencap'
      f = Screencap::Fetcher.new(@note.content)
      screenshot = f.fetch
      # r = Random.new
      # r.rand(1...1000)
      # f = Screencap::Fetcher.new('http://google.com')
      # screenshot = f.fetch( :output => Rails.root.join('/screenshots/' + r + '.png' ) )
      # note.image = Rails.root.join('/screenshots/' + r + '.png').open
    end

    respond_to do |format|
      if @note.save
        @note.reload
        format.json {render :show, status: :created, location: @note}
        format.js
      else
        logger.error("Error Creating Note: " + @note.errors.full_messages.first)
        format.json {render json: @note.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  def new_modal
    @note = Note.new
    @note.note_type = 'note'
    @note.project = Project.find(params[:project_id])
    @note.author = current_user


    respond_to do |format|
      format.js
    end
  end

  def update
    if @note.invalid?
      logger.error("Note not updated successfully")
      log.error(@note.errors)
    end

    respond_to do |format|
      if @note.update(note_params)
        format.json {render :show, status: :ok, location: @note}
        format.js
      else
        format.json {render json: @note.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.js
      format.json {head :no_content}
    end
  end

  private
  def set_note
    @note = Note.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:content, :note_type, :content, :git_commit_id, :project_id, :discussion_id, :author_id)
  end
end

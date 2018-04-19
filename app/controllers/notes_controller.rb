class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def delete_note_inline
    id = params[:note_id]
    @note = Note.find(id)
    @project = @note.project
    @note.destroy

    @notes = @project.notes.order('created_at DESC').all

    respond_to do |format|
      format.js
    end
  end

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
    @note.author = current_user
    @note.project = Project.find(params[:project_id])
    @note.note_type = 'note'

    unless @note.project.current_sprint.nil?
      @note.invoice = @note.project.current_sprint
    end

    unless @note.project.current_task.nil?
      @note.invoice_item = @note.project.current_task
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.author = current_user

    project = @note.project
    unless project.current_sprint.nil?
      @note.invoice = project.current_sprint
    end

    unless project.current_task.nil?
      @note.invoice_item = project.current_task
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

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    if @note.invalid?
      logger.error("Note not updated succesfully")
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

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html {redirect_to notes_url, notice: 'Note was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    params.require(:note).permit(:content, :note_type, :content, :git_commit_id, :project_id, :discussion_id, :author_id)
  end
end

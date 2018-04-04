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

  def create_note_modal

    logger.info("Executing Note Modal")

    @project = Project.find(params[:project_id])

    @note = Note.create_note(@project, current_user, params[:content])

    if @note.invalid?
      @note.errors.each do |e|
        logger.error(e)
      end
      redirect_to root_path, notice: 'Note was NOT created.'
    end

    @notes = @project.notes.order('created_at DESC').all

    respond_to do |format|
      format.js
    end
  end

  def create_project_update_modal

    logger.info("Executing Project Update Modal")

    @project = Project.find(params[:project_id])

    @note = Note.create_project_update(@project, current_user, params[:content])

    if @note.invalid?
      @note.errors.each do |e|
        logger.error(e)
      end
      redirect_to root_path, notice: 'Note was NOT created.'
    end

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
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

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
        @notes = Note.all

        format.html {redirect_to @note, notice: 'Note was successfully created.'}
        format.json {render :show, status: :created, location: @note}
        format.js
      else
        format.html {render :new}
        format.json {render json: @note.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html {redirect_to @note, notice: 'Note was successfully updated.'}
        format.json {render :show, status: :ok, location: @note}
      else
        format.html {render :edit}
        format.json {render json: @note.errors, status: :unprocessable_entity}
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

# frozen_string_literal: true

class SprintsController < ApplicationController
  before_action :set_sprint, only: %i[edit_description render_panel
                                      set_current request_payment cancel_payment_request
                                      open close show edit update destroy]
  after_action :gather_errors
  respond_to :json, :html, only: %i[show edit update destroy]
  respond_to :js, only: %i[edit_description render_panel open close show
                           edit update destroy request_payment cancel_payment_request]

  def index
    @project = Project.includes(:payments, :tasks).find(params[:project_id])
  end

  def show;
  end

  def edit;
  end

  def update
    respond_to do |format|
      format.js
      if @sprint.update(sprint_id_params)
        format.html {redirect_to @sprint, notice: 'Sprint was successfully updated.'}
        format.json {render :show, status: :ok, location: @sprint}
      else
        @sprint.errors.full_messages.map {|e| @errors << 'Error Closing Sprint: ' + e}
        format.html {render :edit}
        format.json {render json: @sprint.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit_description;
  end

  def render_panel;
  end

  def set_current
    @old_sprint = @project.current_sprint
    @project.current_sprint = @sprint
    @project.current_task = nil unless @project.current_task.nil?
    @project.save
    @project.reload
    @sprint.reload
    @old_sprint.reload
    Note.create_event(@project, 'current_sprint_changed', 'Current Sprint Changed From ' + @old_sprint.sprint.to_s + ' to ' + @sprint.sprint.to_s) if @project.valid?
    @current_sprint = @project.sprint_current
  end

  def request_payment
    if @sprint.cost > 0
      @sprint.payment_due = true
      @sprint.save
      @user = current_user
      @project = @sprint.project
      Note.create_payment_request(@sprint, current_user) if @sprint.valid?
    end
  end

  def cancel_payment_request
    @sprint.payment_due = false
    @sprint.save
    @user = current_user
    Note.create_event(@sprint.project, 'payment_request_cancelled', 'Sprint ' +
        @sprint.sprint.to_s + ' Payment Request Canceled')
  end

  def open
    @sprint.open = true
    @sprint.save
    Note.create_event(@sprint.project, 'sprint_opened', 'Sprint ' + @sprint.sprint.to_s + ' Opened ')
    # TODO: Get rid of this if we dont need it @sprint.reload
  end

  def close
    @sprint.open = false
    @sprint.save
    Note.create_event(@sprint.project, 'sprint_closed', 'Sprint ' + @sprint.sprint.to_s + ' Closed ')
    # TODO: Get rid of this if we dont need it @sprint.reload
  end

  private

  def set_sprint
    logger.error 'SprintController Error: Sprint could not be set (nil) for View' if @sprint.nil?
    @sprint = Sprint.find(params[:id])
    @project = @sprint.project
  end

  def gather_errors
    @sprint.errors.full_messages.map {|e| @errors << 'Error Closing Sprint: ' + e} if defined? @sprint
  end

  private

  def sprint_id_params
    params.require(:sprint).permit(:sprint, :payment_due_date, :open, :payment_due, :description)
  end
end

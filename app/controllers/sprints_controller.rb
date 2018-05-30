# frozen_string_literal: true

class SprintsController < ApplicationController
  include Sprint::Ajaxable

  def index; end

  def show; end

  def new
    @sprint = Sprint.new
  end

  def edit; end

  def create
    @sprint = Sprint.new(sprint_id_params)

    respond_to do |format|
      if @sprint.save

        @sprint.project.create_note('project_update', 'Created Sprint ' + @sprint.sprint.to_s)

        format.html { redirect_to @sprint, notice: 'Sprint was successfully created.' }
        format.json { render :show, status: :created, location: @sprint }
      else
        format.html { render :new }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sprint.update(sprint_id_params)
        format.html { redirect_to @sprint, notice: 'Sprint was successfully updated.' }
        format.json { render :show, status: :ok, location: @sprint }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private

  def sprint_id_params
    params.require(:sprint).permit(:sprint, :payment_due_date, :payment_due, :description)
  end
end

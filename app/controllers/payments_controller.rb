# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  def display_panel
    @project = Project.find(params[:project_id])
    @user = current_user
    respond_to do |format|
      format.js
    end
  end

  def index
    @project = Project.includes(:tasks).find(params[:project_id])
  end

  def show; end

  def new
    @payment = Payment.new
  end

  def edit; end

  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save

        @payment.sprint.project.create_note('project_update', @payment.user.first_name + ' ' + @payment.user.last_name +
            ' Made a Payment of $' + @payment.amount.to_s + ' for Sprint ' + @payment.sprint.sprint.to_s)

        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:payment_type, :payment_identifier, :payment_note, :amount, :belongs_to, :belongs_to)
  end
end

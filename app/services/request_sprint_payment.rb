# frozen_string_literal: true

# Request payment on the Sprint passed-in
class RequestSprintPayment < Jeweler::Service
  def initialize(sprint, current_user)
    @sprint = sprint
    @current_user = current_user
  end

  def call
    if sprint.hours.zero?
      @errors << 'You must report hours to request payment.'
    elsif sprint.payment_due
      @errors << 'Payment already Requested.'
    else
      sprint.update(payment_due: true)
      if sprint.valid?
        Note.create_payment_request(sprint, current_user)
      else
        sprint.errors.full_messages.map { |e| fatals << 'Error Requesting Payment: ' + e}
      end
    end
    sprint
  end

  private

  attr_reader :sprint, :current_user
end

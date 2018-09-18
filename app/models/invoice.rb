# An Invoice is simply a group of configuration settings for a Sprint
class Invoice
  include ActiveModel::Model
  include Virtus.model

  attribute :sprint, Sprint
  attribute :estimate, Boolean, default: true
  attribute :display_print_btn, Boolean, default: false
  attribute :display_pay_btn, Boolean, default: false
  attribute :display_send_btn, Boolean, default: false
  attribute :display_estimate_hours, Boolean, default: false #TODO: Unimplemented
  attribute :user, User, default: false
  attribute :customer_email, String, default: false
  attribute :request_amount, Float, default: false
  attribute :display_payments, Boolean, default: false
  attribute :invoice_note, String, default: false
  attribute :invitation, Boolean, default: false
  # goal: 'print' or 'send'
  attribute :goal, String, default: false

  def to_partial_path
    'invoices/invoice'
  end

end
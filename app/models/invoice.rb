# An Invoice is simply a group of configuration settings for a Sprint
class Invoice
  include ActiveModel::Model
  include Virtus.model(:nullify_blank => true)

  attribute :sprint, Sprint
  attribute :estimate, Boolean, default: true
  attribute :display_print_btn, Boolean, default: false
  attribute :display_pay_btn, Boolean, default: false
  attribute :display_send_btn, Boolean, default: false
  attribute :display_estimate_hours, Boolean, default: false #TODO: Unimplemented
  attribute :user, User, default: nil
  attribute :customer_email, String, default: nil
  attribute :request_amount, Float, default: 0.00
  attribute :display_payments, Boolean, default: false
  attribute :invoice_note, String, default: nil
  attribute :invitation, Boolean, default: false
  # goal: 'print' or 'send'
  attribute :goal, String, default: nil

  def to_partial_path
    'invoices/invoice'
  end

end
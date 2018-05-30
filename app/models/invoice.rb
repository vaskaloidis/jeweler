class Invoice < ApplicationRecord
  include Virtus.model

  attribute :sprint, Integer
  attribute :customer_id, Integer
  attribute :customer_email, String, default: ''
  attribute :payment_requested, Boolean
  attribute :payment_request_amount, Float

end

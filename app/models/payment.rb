class Payment < ApplicationRecord
  enum payment_type: [ :venmo, :paypal, :credit_card, :jeweler, :bank_transfer, :check, :cash ]

  belongs_to :invoice
  belongs_to :user

  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :user

  def self.payment_types
    payment_types = Array.new
    payment_types << 'all'
    payment_types << 'venmo'
    payment_types << 'paypal'
    payment_types << 'credit_card'
    payment_types << 'jewler_payment'
    payment_types << 'bank_transfer'
    payment_types << 'check'
    payment_types << 'cash'
  end

end

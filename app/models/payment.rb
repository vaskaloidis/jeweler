class Payment < ApplicationRecord
  enum payment_type: [ :venmo, :paypal, :credit_card, :jewler, :bank_transfer, :check ]

  belongs_to :invoice
  belongs_to :user

  accepts_nested_attributes_for :invoice
  accepts_nested_attributes_for :user

end

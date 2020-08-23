class Payment < ApplicationRecord
  enum payment_type: [ :venmo, :paypal, :credit_card, :jeweler, :bank_transfer, :check, :cash ]

  has_one :project, through: :sprint
  belongs_to :sprint
  belongs_to :user
    include Eventable
  # has_many :events, as: :eventable, dependent: :destroy

  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :sprint
  accepts_nested_attributes_for :user

  validates :amount, numericality: { message: 'Must be Present.' }


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

class InvoiceItem < ApplicationRecord
  belongs_to :invoice

  accepts_nested_attributes_for :invoice

end

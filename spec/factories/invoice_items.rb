FactoryBot.define do
  factory :invoice_item do
    description "MyText"
    hours "9.99"
    rate "9.99"
    item_type "MyString"
    complete false
    belongs_to ""
  end
end

FactoryBot.define do
  factory :payment do
    payment_type 1
    payment_identifier "MyString"
    payment_note "MyString"
    ammount "9.99"
    belongs_to ""
    belongs_to ""
  end
end

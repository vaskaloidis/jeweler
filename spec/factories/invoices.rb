FactoryBot.define do
  factory :invoice do
    sprint_ 1
    payment_due_date "2018-03-05"
    payment_due false
    description "MyText"
    belongs_to ""
  end
end

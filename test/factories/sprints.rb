FactoryBot.define do
  factory :invoice do
    payment_due false
    description Faker::ChuckNorris.fact
    open Faker::Internet.domain_name
    sequence(:sprint)
    after(:create) do |invoice, evaluator|
      create_list(:invoice_item, 5, invoice: invoice)
    end
  end
end

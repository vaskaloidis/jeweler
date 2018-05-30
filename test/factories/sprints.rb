FactoryBot.define do
  factory :sprint, class: 'Sprint' do
    payment_due false
    description Faker::ChuckNorris.fact
    open Faker::Internet.domain_name
    sequence(:sprint)
    project

    after(:create) do |sprint, evaluator|
      create_list(:task, 5, sprint: sprint)
    end
  end
end

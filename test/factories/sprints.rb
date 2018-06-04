FactoryBot.define do
  factory :sprint, class: 'Sprint' do
    payment_due false
    description Faker::ChuckNorris.fact
    add_attribute(:open) { 'true' }
    sequence(:sprint)
    project
    after(:create) do |sprint, evaluator|
      create_list(:task, 3, sprint: sprint)
      create_list(:note, 2, sprint: sprint)
    end
  end
end

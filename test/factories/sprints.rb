FactoryBot.define do
  factory :sprint, class: 'Sprint' do
    payment_due false
    description 'A long string'
    add_attribute(:open) {'true'}
    sequence(:sprint)
    project
    after(:create) do |sprint, evaluator|
      create_list(:planned_task, 3, sprint: sprint)
      create_list(:note, 2, sprint: sprint)
    end
    factory :regular_sprint do
      after(:create) do |sprint, evaluator|
        create_list(:task, 3, sprint: sprint)
      end
    end
    factory :sprint_with_reported_hours do
      after(:create) do |sprint, evaluator|
        create_list(:task, 5, sprint: sprint, hours: Random.rand(1...20))
      end
    end
  end
end

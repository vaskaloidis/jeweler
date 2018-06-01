FactoryBot.define do
  factory :task, class: Task do
    description Faker::ChuckNorris.fact
    hours Random.rand(20)
    rate Random.rand(50)
    complete false
    association :sprint
    planned_hours Random.rand(20)
    sequence(:position)
    deleted false

    factory :task_update do
      description 'updated desc'
      rate '12'
      planned_hours '13'
      hours '14'
      complete true
    end
  end

  factory :new_task, class: Task do
    association :sprint
    description 'new task desc'
    rate '13'
    planned_hours '14'
    hours '15'
    sequence(:position)
  end

end

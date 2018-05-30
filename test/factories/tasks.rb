FactoryBot.define do
  factory :task, class: 'Task' do
    description Faker::ChuckNorris.fact
    hours Random.rand(20)
    rate Random.rand(50)
    complete false
    sprint
    planned_hours Random.rand(20)
    sequence(:position)
    deleted false

    factory :new_task do
      sprint
      description 'new task desc'
      rate '13'
      planned_hours '14'
      hours '15'
    end

    factory :task_update do
      sprint
      description 'updated desc'
      rate '12'
      planned_hours '13'
      hours '14'
      complete true
    end
  end

end

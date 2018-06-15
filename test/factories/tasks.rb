FactoryBot.define do
  factory :task, class: 'Task' do
    description Faker::ChuckNorris.fact
    hours Random.rand(20)
    rate Random.rand(50)
    complete false
    sprint
    planned_hours Random.rand(20)
    deleted false

    factory :planned_task do
      hours 0
      planned_hours Random.rand(1...20)
    end

    factory :task_update do
      description 'updated desc'
      rate '12'
      planned_hours '13'
      hours '14'
      complete true
    end
    factory :new_task, class: 'Task' do
      description 'new task desc'
      rate '13'
      planned_hours '14'
      hours '15'
    end
    factory :task_in_current_sprint do
      association :sprint, factory: :current_sprint
    end
    factory :current_task_in_current_sprint do
      # after(:create) do |task, evaluator|
      #   association :sprint, factory: :current_sprint, current_task: sprint
      # end
    end
  end

end

FactoryBot.define do
  factory :task, class: 'Task' do
    sprint
    description {Faker::ChuckNorris.fact}
    hours {Random.rand(20)}
    rate {Random.rand(50)}
    complete {false}
    planned_hours {Random.rand(20)}
    deleted {false}
    created_by {sprint.project.owner}
    add_attribute(:assigned_to)

    factory :planned_task do
      hours {0}
      planned_hours {Random.rand(1...20)}
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

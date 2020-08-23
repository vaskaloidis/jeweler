FactoryBot.define do
  factory :event do

    trait :for_note do
      association :eventable, factory: :note
    end

    trait :for_payment do
      association :eventable, factory: :payments
    end

    trait :for_commits do
      association :eventable, factory: :commits
    end

    trait :for_commits do
      association :eventable, factory: :commits
    end

    trait :for_tasks do
      association :eventable, factory: :tasks
    end

  end
end

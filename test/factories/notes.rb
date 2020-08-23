FactoryBot.define do
  factory :note, class: 'Note' do
    content Faker::ChuckNorris.fact
    note_type { :owner_note }
    author
    # task
    # sprint { task.sprint }
    # project { task.sprint.project }
    project { sprint.project }
    sprint
    after(:create) do |note|
      create_list(:discussion, 3, note: note)
    end

    trait :owner_note do
	    note_type :owner_note
    end

    trait :developer_note do
	    note_type :developer_note
    end

    trait :customer_note do
	    note_type :customer_note
    end

    trait :project_update_note do
	    note_type :project_update_note
    end

    trait :demo do
	    note_type :demo
    end
  end
end
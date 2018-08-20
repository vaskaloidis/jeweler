FactoryBot.define do
  factory :note, class: 'Note' do
    content 'A long string'
    note_type 'note'
    author
    # task
    # sprint { task.sprint }
    # project { task.sprint.project }
    project { sprint.project }
    sprint
    after(:create) do |note|
      create_list(:discussion, 3, note: note)
    end
  end
end
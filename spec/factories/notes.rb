FactoryBot.define do
  factory :note do
    content "MyString"
    note_type 1
    content "MyText"
    git_commit_id "MyString"
    project nil
    discussion nil
    author nil
  end
end

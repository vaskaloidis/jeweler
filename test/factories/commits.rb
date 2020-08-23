FactoryBot.define do
  factory :commit do
    sync { false }
    git_commit_id { "MyString" }
    git_diff { "MyString" }
    sprint { nil }
    task { nil }
  end
end

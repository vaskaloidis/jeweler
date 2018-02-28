FactoryBot.define do
  factory :project do
    name Faker::Company.buzzword
    language Faker::ProgrammingLanguage.name
    demo_url Faker::Internet.url
    prod_url Faker::Internet.url
    github_url Faker::Internet.url('github.com')
    github_secondary_url Faker::Internet.url('github.com')
    description Faker::Company.catch_phrase
    association :owner, factory: :user
  end
end
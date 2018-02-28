FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    website_url Faker::Internet.url
    bio Faker::ChuckNorris.fact
    location Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
  end
  factory :project do
    name Faker::Company.catch_phrase
    language Faker::ProgrammingLanguage.name
    demo_url Faker::Internet.url
    prod_url Faker::Internet.url
    github_url Faker::Internet.url('https://github.com/vaskaloidis/')
    description Faker::ChuckNorris.fact
    association :owner, factory: :user
  end
end
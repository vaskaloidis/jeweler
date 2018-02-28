FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    website_url Faker::Internet.url
    bio Faker::ChuckNorris.fact
    location Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
    factory :customer_projects, class: ProjectCustomer do
      association :user, factory: :user
      association :project, factory: :project
    end
  end
end
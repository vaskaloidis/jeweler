# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user, class: 'User', aliases: %i[author owner customer] do
    email
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    password {Faker::Internet.password}
    password_confirmation { password.to_s }
    confirmed_at {Time.now}

    factory :valid_user, class: 'User' do
      company {Faker::Company.name}
      website_url {Faker::Internet.url}
      tagline {Faker::MostInterestingManInTheWorld}
      location {Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country}
      # stripe_account_id Faker::Stripe.valid_card
      # DO NOT Set in default user factory! oauth Faker::Omniauth.github[:credentials][:token]
    end
  end
end

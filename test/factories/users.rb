# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user, class: 'User', aliases: %i[author owner customer] do
    email
    first_name 'A-String'
    last_name 'A-String'
    password 'A-String'
    password_confirmation { password.to_s }
    confirmed_at Time.now

    factory :valid_user, class: 'User' do
      company 'A-String'
      website_url 'www.example.com'
      tagline 'A-String'
      location 'A Location'
      # stripe_account_id Faker::Stripe.valid_card
      # DO NOT Set in default user factory! oauth Faker::Omniauth.github[:credentials][:token]
    end
  end
end

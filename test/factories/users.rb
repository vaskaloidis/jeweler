FactoryBot.define do
  factory :user, class: User, aliases: [:author, :owner, :customer] do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password
    password_confirmation {"#{password}"}

    factory :valid_user do
      company Faker::ChuckNorris.fact
      website_url Faker::Internet.url
      tagline Faker::ChuckNorris.fact
      bio Faker::ChuckNorris.fact
      location Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
      stripe_account_id Faker::Stripe.valid_card
      oauth Faker::Omniauth.github[:credentials][:token]
    end

    factory :invalid_name_user do
      first_name ''
      last_name ''
    end

    factory :invalid_email_user do
      email ''
    end

    factory :vas do
      email 'vas.kaloidis@gmail.com'
      first_name 'Vas'
      last_name 'Kaloidis'
      password 'password'
      password_confirmation 'password'
    end

  end
end
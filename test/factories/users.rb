FactoryBot.define do
  factory :user, class: 'User', aliases: [:author] do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password
    password_confirmation {"#{password}"}
    confirmed_at Time.now

    factory :valid_user do
      email Faker::Internet.email
      company Faker::Company.name
      website_url Faker::Internet.url
      tagline Faker::MostInterestingManInTheWorld
      location Faker::Address.city + ', ' + Faker::Address.state + ', ' + Faker::Address.country
      # stripe_account_id Faker::Stripe.valid_card
      # oauth Faker::Omniauth.github[:credentials][:token]

      factory :owner do
        email Faker::Internet.email
      end

      factory :customer do
        email Faker::Internet.email
      end
    end

    factory :invalid_name_user do
      first_name ''
      last_name ''
    end
    factory :invalid_email_user do
      email ''
    end
  end

end
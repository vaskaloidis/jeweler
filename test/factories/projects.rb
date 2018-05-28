FactoryBot.define do
  factory :project do
    transient do
      phases { Random.rand(15) }
    end
    name Faker::App.name
    language Faker::ProgrammingLanguage.name
    sprint_total { phases }
    sprint_current { Random.rand(phases) }
    description Faker::ChuckNorris.fact
    github_url { Faker::Omniauth.github[:info][:urls][:GitHub] + name }
    stage_website_url Faker::Internet.domain_name
    demo_url Faker::Internet.domain_name
    prod_url Faker::Internet.domain_name
    complete false
    association :owner, factory: :owner
    # heroku_token Faker::Omniauth.github['uid']
    # google_analytics_tracking_code Faker::Omniauth.google[:credentials][:token]

    after(:create) do |project, evaluator|
      create_list(:invoice, evaluator.phases, project: project)
    end

  end
end

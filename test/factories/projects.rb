FactoryBot.define do
  factory :project, class: 'Project' do
    transient do
      phases 15
    end
    name Faker::App.name
    language Faker::ProgrammingLanguage.name
    sprint_total 15
    sprint_current 1
    # sprint_total { phases }
    # sprint_current { Random.rand(phases) }
    description Faker::ChuckNorris.fact
    github_url {Faker::Omniauth.github[:info][:urls][:GitHub] + name}
    stage_website_url Faker::Internet.domain_name
    demo_url Faker::Internet.domain_name
    prod_url Faker::Internet.domain_name
    complete false
    association :owner, factory: :owner, email: Faker::Internet.email
    # heroku_token Faker::Omniauth.github['uid']
    # google_analytics_tracking_code Faker::Omniauth.google[:credentials][:token]

    factory :project_with_sprints do
      after(:create) do |project, evaluator|
        create_list(:sprint, evaluator.phases, project: project)
      end
    end
  end

  factory :new_project, class: 'Project' do
    name 'new project name'
    language 'rails'
    sprint_total 10
    sprint_current 1
    description 'new project desc'
    github_url 'http://github.com/user/project'
    stage_website_url 'project stage url'
    demo_url 'project demo url'
    prod_url 'project prod url'
    owner
  end

  factory :update_project, class: 'Project' do
    name 'update project name'
    language 'java'
    sprint_total '12'
    sprint_current '2'
    description 'update project desc'
    github_url 'http://github.com/update-user/project'
    stage_website_url 'project update stage url'
    demo_url 'project update demo url'
    prod_url 'project update prod url'
    owner
  end

end

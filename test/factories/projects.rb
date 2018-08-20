FactoryBot.define do
  factory :project, class: 'Project' do
    transient do
      phases 5
    end
    name 'A-String'
    language 'Rails'
    sprint_total '5'
    sprint_current '1'
    # sprint_total { phases }
    # sprint_current { Random.rand(phases) }
    description 'A long string'
    github_url 'www.github.com/username/repository'
    stage_website_url 'www.example.com'
    demo_url 'www.example.com'
    prod_url 'www.example.com'
    complete false
    association :owner, factory: :owner
    # heroku_token Faker::Omniauth.github['uid']
    # google_analytics_tracking_code Faker::Omniauth.google[:credentials][:token]
    # after(:create) do |project, evaluator|
    #   create_list(:sprint, evaluator.phases, project: project)
    # end
    after(:create) do |project, evaluator|
      # TODO: Iterate over Sprints here, creating tasks
      create_list(:task, 2, sprint: evaluator.get_sprint(1))
      create_list(:note, 2, sprint: evaluator.get_sprint(1))
      create_list(:task, 2, sprint: evaluator.get_sprint(2))
      create_list(:note, 2, sprint: evaluator.get_sprint(2))
      create_list(:task, 2, sprint: evaluator.get_sprint(3))
      create_list(:note, 2, sprint: evaluator.get_sprint(3))
      create_list(:task, 2, sprint: evaluator.get_sprint(4))
      create_list(:note, 2, sprint: evaluator.get_sprint(4))
      create_list(:task, 2, sprint: evaluator.get_sprint(5))
      create_list(:note, 2, sprint: evaluator.get_sprint(5))
      create_list(:project_customer, 2, project: project)
    end
    factory :project_with_github_test_repo do
      github_url 'https://github.com/vaskaloidis/jeweler_test_repo'
    end
    factory :project_with_current_task do
      after(:create) do |project, evaluator|
        project.current_task || create(:task, sprint: evaluator.current_sprint)
      end
    end
  end

  factory :project_only, class: 'Project' do
    transient do
      phases 5
    end
    name 'A-String'
    language 'Rails'
    sprint_total '5'
    sprint_current '1'
    # sprint_total { phases }
    # sprint_current { Random.rand(phases) }
    description 'A long string'
    github_url 'www.github.com/username/repository_name'
    stage_website_url 'www.example.com'
    demo_url 'www.example.com'
    prod_url 'www.example.com'
    complete false
    association :owner, factory: :owner
  end

  factory :new_project, class: 'Project' do
    name 'new project name'
    language 'rails'
    sprint_total '10'
    sprint_current '1'
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

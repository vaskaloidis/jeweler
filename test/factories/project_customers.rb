FactoryBot.define do
  factory :project_customer, class: 'ProjectCustomer' do
    project
    user
  end
end
FactoryBot.define do
  factory :invitation, class: 'Invitation' do
    email
    project
    add_attribute(:user_type)
  end
end
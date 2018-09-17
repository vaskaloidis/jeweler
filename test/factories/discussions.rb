FactoryBot.define do
  factory :discussion, class: 'Discussion' do
    content Faker::ChuckNorris.fact
    user
    note
  end
end
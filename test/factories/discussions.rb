FactoryBot.define do
  factory :discussion, class: 'Discussion' do
    content 'A long string'
    user
    note
  end
end
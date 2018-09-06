FactoryBot.define do
  factory :payment, class: 'Payment' do
    payment_type 1
    amount Random.rand
    sprint
    user
  end
end
FactoryBot.define do
  factory :payment, class: Note do
    payment_type 1
    amount Random.rand
    sprint
    association :user, factory: customer
  end
end
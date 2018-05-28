FactoryBot.define do
  factory :invoice_item do
    description Faker::ChuckNorris.fact
    hours Random.rand(20)
    rate Random.rand(50)
    complete false
    invoice
    planned_hours Random.rand(20)
    sequence(:position)
    deleted false

    factory :invoice_item_update do
      description 'updated desc'
      rate '12'
      planned_hours '13'
      hours '14'
      complete true
    end

  end
end

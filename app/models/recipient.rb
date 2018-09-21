class Recipient
  include Virtus.value_object

  values do
    attribute :id, Integer, default: false
    attribute :email, String
    attribute :name, String
  end
end
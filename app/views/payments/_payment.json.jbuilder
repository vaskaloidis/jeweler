json.extract! payment, :id, :payment_type, :payment_identifier, :payment_note, :ammount, :belongs_to, :belongs_to, :created_at, :updated_at
json.url payment_url(payment, format: :json)

json.extract! invoice, :id, :phase, :payment_due_date, :payment_due, :description, :belongs_to, :created_at, :updated_at
json.url sprint_url(invoice, format: :json)

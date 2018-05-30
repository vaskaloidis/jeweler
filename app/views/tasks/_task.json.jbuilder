json.extract! invoice_item, :id, :description, :planned_hours, :deleted, :hours, :rate, :item_type, :complete, :belongs_to, :created_at, :updated_at
json.url task_url(invoice_item, format: :json)

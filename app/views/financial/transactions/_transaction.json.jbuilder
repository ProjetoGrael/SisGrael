json.extract! transaction, :id, :value, :payer, :receiver, :account_id, :cost_id, :cost_type, :transaction_category_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

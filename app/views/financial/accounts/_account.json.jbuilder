json.extract! account, :id, :number, :bank, :current_value, :created_at, :updated_at
json.url account_url(account, format: :json)

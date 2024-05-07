json.extract! project, :id, :title, :description, :total_value, :current_value, :created_at, :updated_at
json.url project_url(project, format: :json)

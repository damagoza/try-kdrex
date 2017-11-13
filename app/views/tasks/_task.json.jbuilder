json.extract! task, :id, :name, :project_id, :user_id, :start_task, :end_task, :state, :created_at, :updated_at
json.url task_url(task, format: :json)

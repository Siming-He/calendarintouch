json.extract! task, :id, :name, :duedate, :description, :subject_id, :created_at, :updated_at
json.url task_url(task, format: :json)

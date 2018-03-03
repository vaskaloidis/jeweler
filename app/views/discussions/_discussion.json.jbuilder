json.extract! discussion, :id, :note_id, :user_id, :content, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)

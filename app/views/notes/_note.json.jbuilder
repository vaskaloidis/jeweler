json.extract! note, :id, :content, :note_type, :content, :git_commit_id, :project_id, :discussion_id, :author_id, :created_at, :updated_at
json.url note_url(note, format: :json)

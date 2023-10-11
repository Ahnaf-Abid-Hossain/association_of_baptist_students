json.extract!(meeting_note, :id, :title, :content, :date, :alumni_id, :created_at, :updated_at)
json.url(meeting_note_url(meeting_note, format: :json))

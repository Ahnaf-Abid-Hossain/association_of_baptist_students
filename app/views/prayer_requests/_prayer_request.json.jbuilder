json.extract!(prayer_request, :id, :request, :status, :id, :created_at, :updated_at)
json.url(prayer_request_url(prayer_request, format: :json))

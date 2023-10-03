json.extract!(link, :id, :label, :url, :order, :created_at, :updated_at)
json.url(link_url(link, format: :json))

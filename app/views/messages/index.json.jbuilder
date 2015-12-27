json.array!(@messages) do |message|
  json.extract! message, :id, :from_user_id, :body
  json.url message_url(message, format: :json)
end

json.array!(@observers) do |observer|
  json.extract! observer, :id, :name, :email
  json.url observer_url(observer, format: :json)
end

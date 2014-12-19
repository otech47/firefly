json.array!(@teams) do |team|
  json.extract! team, :id, :name, :repo, :video, :admin
  json.url team_url(team, format: :json)
end

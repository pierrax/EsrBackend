json.array!(@codes) do |code|
  json.id code.id
  json.content code.content
  json.category code.category.title
  json.date_start code.date_start
  json.date_end code.date_end
  json.status code.status
end

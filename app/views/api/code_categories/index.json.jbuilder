json.array!(@categories) do |category_code|
  json.id category_code.id
  json.title category_code.title
  json.position category_code.position
end

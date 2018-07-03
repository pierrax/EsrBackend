json.array!(@categories) do |category|
  json.id category.id
  json.title category.title
  json.origin category.origin
  json.position category.position
end

json.array!(@categories) do |category_link|
  json.id category_link.id
  json.title category_link.title
  json.position category_link.position
end

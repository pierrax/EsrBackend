json.array!(@category_links) do |category_link|
  json.id category_link.id
  json.title category_link.title
end

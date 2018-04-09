json.array!(@category_codes) do |category_code|
  json.id category_code.id
  json.title category_code.title
end

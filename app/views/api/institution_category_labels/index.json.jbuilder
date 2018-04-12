json.array!(@category_labels) do |label|
  json.id label.id
  json.short_label label.short_label
  json.long_label label.long_label
end

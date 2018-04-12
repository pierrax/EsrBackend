json.array!(@links) do |link|
  json.id link.id
  json.institution_id link.institution_id
  json.category link.category.title
  json.content link.content
  json.date_start link.date_start
  json.date_end link.date_end
  json.status link.status
end

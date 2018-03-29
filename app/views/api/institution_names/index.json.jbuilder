json.array!(@institution_names) do |name|
  json.id name.id
  json.text name.text
  json.initials name.initials
  json.date_start name.date_start
  json.date_end name.date_end
  json.status name.status
end

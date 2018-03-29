json.id institution.id
json.date_start institution.date_start
json.date_end institution.date_end
json.names(institution.names) do |name|
  json.id name.id
  json.status name.status == 0 ? 'Archived' : 'Active'
  json.text name.text
  json.initials name.initials
  json.date_start name.date_start
  json.date_end name.date_end
end

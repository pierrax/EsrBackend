json.id institution.id
json.date_start institution.date_start
json.date_end institution.date_end
json.names(institution.names) do |name|
  json.id name.id
  json.status name.status
  json.text name.text
  json.initials name.initials
  json.date_start name.date_start
  json.date_end name.date_end
end
json.addresses(institution.addresses) do |address|
  json.id address.id
  json.business_name address.business_name
  json.address_1 address.address_1
  json.address_2 address.address_2
  json.zip_code address.zip_code
  json.city address.city
  json.country address.country
  json.phone address.phone
  json.latitude address.latitude
  json.longitude address.longitude
  json.date_start address.date_start
  json.date_end address.date_end
  json.status address.status
end
json.links(institution.links) do |link|
  json.id link.id
  json.content link.content
  json.category link.category.title
end
json.codes(institution.codes) do |code|
  json.id code.id
  json.content code.content
  json.category code.category.title
  json.date_start code.date_start
  json.date_end code.date_end
  json.status code.status
end
json.tags(institution.tags) do |tag|
  json.id tag.id
  json.short_label tag.label.short_label
  json.long_label tag.label.long_label
  json.category tag.category.title
  json.date_start tag.date_start
  json.date_end tag.date_end
  json.status tag.status
end
json.predecessors(institution.predecessors) do |institution|
  json.id institution.id
end
json.followers(institution.followers) do |institution|
  json.id institution.id
end
json.mothers(institution.mothers) do |institution|
  json.id institution.id
end
json.daughters(institution.daughters) do |institution|
  json.id institution.id
end

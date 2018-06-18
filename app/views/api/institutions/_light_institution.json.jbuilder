json.id institution.id
json.names(institution.names) do |name|
  json.id name.id
  json.text name.text
  json.initials name.initials
end
json.addresses(institution.addresses) do |address|
  json.id address.id
  json.business_name address.business_name
  json.address_1 address.address_1
  json.address_2 address.address_2
  json.zip_code address.zip_code
  json.city address.city
  json.country address.country
  json.status address.status
end
json.codes(institution.codes) do |code|
  json.id code.id
  json.content code.content
  json.category code.category.title
end
json.tags(institution.tags) do |tag|
  json.id tag.id
  json.short_label tag.short_label
  json.long_label tag.long_label
end

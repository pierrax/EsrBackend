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

if @active
  json.institution do
    json.id @institution.id
    json.date_start @institution.date_start
    json.date_end @institution.date_end
    json.synonym @institution.synonym
    json.name do
      json.id @institution.names.try(:active).try(:first).try(:id)
      json.status @institution.names.try(:active).try(:first).try(:status)
      json.text @institution.names.try(:active).try(:first).try(:text)
      json.initials @institution.names.try(:active).try(:first).try(:initials)
      json.date_start @institution.names.try(:active).try(:first).try(:date_start)
      json.date_end @institution.names.try(:active).try(:first).try(:date_end)
    end
    json.address do
      json.id @institution.addresses.try(:active).try(:first).try(:id)
      json.business_name @institution.addresses.try(:active).try(:first).try(:business_name)
      json.address_1 @institution.addresses.try(:active).try(:first).try(:address_1)
      json.address_2 @institution.addresses.try(:active).try(:first).try(:address_2)
      json.zip_code @institution.addresses.try(:active).try(:first).try(:zip_code)
      json.city @institution.addresses.try(:active).try(:first).try(:city)
      json.country @institution.addresses.try(:active).try(:first).try(:country)
      json.phone @institution.addresses.try(:active).try(:first).try(:phone)
      json.latitude @institution.addresses.try(:active).try(:first).try(:latitude)
      json.longitude @institution.addresses.try(:active).try(:first).try(:longitude)
      json.date_start @institution.addresses.try(:active).try(:first).try(:date_start)
      json.date_end @institution.addresses.try(:active).try(:first).try(:date_end)
      json.status @institution.addresses.try(:active).try(:first).try(:status)
      json.city_code @institution.addresses.try(:active).try(:first).city_code
    end
    json.links(@institution.links) do |link|
      json.id link.id
      json.content link.content
      json.category link.category.title
    end
    json.codes(@institution.codes.active) do |code|
      json.id code.id
      json.content code.content
      json.category code.category.title
      json.date_start code.date_start
      json.date_end code.date_end
      json.status code.status
    end
    json.tags(@institution.tags) do |tag|
      json.id tag.id
      json.short_label tag.short_label
      json.long_label tag.long_label
      json.category tag.category.title
    end
    json.predecessors(@institution.predecessors) do |institution|
      json.id @institution.id
    end
    json.followers(@institution.followers) do |institution|
      json.id @institution.id
    end
    json.mothers(@institution.mothers) do |institution|
      json.id @institution.id
    end
    json.daughters(@institution.daughters) do |institution|
      json.id @institution.id
    end
  end
else
  json.institution @institution, partial: 'api/institutions/institution', as: :institution
end

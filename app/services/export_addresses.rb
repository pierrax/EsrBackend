require 'csv'
class ExportAddresses

  def initialize(collection)
    @addresses = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id InstitutionID BusinessName Adresse1 Adresse2 CodePostal Ville Pays Telephone DateCreation DateFermeture Status CityCode)

      @addresses.each do |address|
        csv << [address.id,
                address.addressable_id,
                address.business_name,
                address.address_1,
                address.address_2,
                address.zip_code,
                address.city,
                address.country,
                address.phone,
                address.date_start,
                address.date_end,
                address.status,
                address.city_code]
      end
    end
  end
end

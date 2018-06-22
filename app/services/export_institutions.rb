require 'csv'
class ExportInstitutions

  def initialize(query)
    institution_ids = Institution.with_name_or_initials(query).pluck(:id)
    @institutions = Institution.includes(:names, :addresses, :codes).where(id: institution_ids)
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(NumeroUAI NomEtablissement SigleEtablissement BusinessName Adresse1 Adresse2 CodePostal Ville Pays Telephone DateCreation)

      @institutions.find_each do |institution|
        address = institution.addresses.active.try(:first)
        name = institution.names.active.first
        
        csv << [institution.code_uai,
                name.try(:text),
                name.try(:initials),
                address.try(:business_name),
                address.try(:address_1),
                address.try(:address_2),
                address.try(:zip_code),
                address.try(:city),
                address.try(:country),
                address.try(:phone),
                institution.date_start]
      end
    end
  end
end

require 'csv'
class ExportInstitutions

  def initialize(collection)
    @institutions = collection
  end

  def call
    institutions_csv = CSV.generate(col_sep: ';') do |csv|
      csv << %w(NumeroUAI NomEtablissement SigleEtablissement BusinessName Adresse1 Adresse2 CodePostal Ville Pays Telephone DateCreation)

      @institutions.each do |institution|
        csv << [institution.code_uai,
                institution.name,
                institution.names.active.first.try(:initials),
                institution.addresses.active.try(:first).try(:business_name),
                institution.addresses.active.try(:first).try(:address_1),
                institution.addresses.active.try(:first).try(:address_2),
                institution.addresses.active.try(:first).try(:zip_code),
                institution.addresses.active.try(:first).try(:city),
                institution.addresses.active.try(:first).try(:country),
                institution.addresses.active.try(:first).try(:phone),
                institution.date_start]
      end
    end

    File.open('tmp/etablissements_ens_sup.csv', 'w:UTF-8') {|file| file.write(institutions_csv)}
  end
end

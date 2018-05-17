require 'csv'
class ImportInstitutions

  UAI_CODE = 0
  NAME = 1
  INITIALS = 2
  BUSINESS_NAME = 3
  ADDRESS_1 = 4
  ADDRESS_2 = 5
  ZIP_CODE = 6
  CITY = 7
  COUNTRY = 8
  PHONE = 9
  DATE_START = 10

  def initialize(file)
    @file = file
    @code_uai = CodeCategory.where(title: 'uai').first
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        code_uai = Code.where(content: row[UAI_CODE], code_category_id: @code_uai.id).first

        if code_uai
          # modify institution
          @institution = code_uai.institution
          @institution.names.active.first.update(text: row[NAME], initials: row[INITIALS])
          @institution.address.update(business_name: row[BUSINESS_NAME], address_1: row[ADDRESS_1], address_2: row[ADDRESS_2], zip_code: row[ZIP_CODE], city: row[CITY], country: row[COUNTRY], phone: row[PHONE] )
        else
          # create institution
          @institution = Institution.create(date_start: row[DATE_START])
          @institution.codes.create(content: row[UAI_CODE], category: @code_uai)
          @institution.names.create(text: row[NAME], initials: row[INITIALS])
          @institution.addresses.create(business_name: row[BUSINESS_NAME], address_1: row[ADDRESS_1], address_2: row[ADDRESS_2], zip_code: row[ZIP_CODE], city: row[CITY], country: row[COUNTRY], phone: row[PHONE] )
        end
      end
    end

    true
  end
end

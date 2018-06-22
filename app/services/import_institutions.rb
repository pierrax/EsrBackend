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
    @errors = []
  end

  def call
    csv_text = File.read(@file)
    ActiveRecord::Base.transaction do
      CSV.parse(csv_text, col_sep: ';', headers: true).each_with_index do |row, i|
        if row
          @code = Code.where(content: row[UAI_CODE], code_category_id: @code_uai.id).first

          if @code
            # modify institution
            @institution = code_uai.institution
            @name = @institution.names.active.first.attributes(text: row[NAME], initials: row[INITIALS])
            @address = @institution.address.attributes(business_name: row[BUSINESS_NAME], address_1: row[ADDRESS_1], address_2: row[ADDRESS_2], zip_code: row[ZIP_CODE], city: row[CITY], country: row[COUNTRY], phone: row[PHONE] )
          else
            # create institution
            @institution = Institution.new(date_start: row[DATE_START])
            @code = @institution.codes.build(content: row[UAI_CODE], category: @code_uai)
            @name = @institution.names.build(text: row[NAME], initials: row[INITIALS])
            @address = Address.new(business_name: row[BUSINESS_NAME], address_1: row[ADDRESS_1], address_2: row[ADDRESS_2], zip_code: row[ZIP_CODE], city: row[CITY], country: row[COUNTRY], phone: row[PHONE], addressable_type: 'Institution')
          end

          objects = [@institution, @code, @name, @address]
          if @institution.valid? && @code.valid? && @name.valid? && valid_address?(row)
            @institution.save!
            @code.save!
            @name.save!
            @address.addressable_id = @institution.id
            @address.save!
          else
            objects.each do |object|
              @errors << "Ligne #{i+2}: #{object.errors.full_messages.join(', ')}" if object.errors.full_messages.present? && !object.errors.full_messages.include?('Addressable must exist')
            end
            objects.each(&:save!)
          end
        end
      end
    end
    true
  rescue ActiveRecord::RecordInvalid => exception
    return @errors.join('; ')
  end

  private
  def valid_address?(row)
    row[ADDRESS_1].present? && row[ADDRESS_1].size > 2 && row[ZIP_CODE].present? && row[CITY].present? && row[COUNTRY].present?
  end
end

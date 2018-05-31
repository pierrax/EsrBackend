require 'csv'
class ImportAddresses

  ADDRESS_ID = 0
  INSTITUTION_ID = 1
  BUSINESS_NAME = 2
  ADDRESS_1 = 3
  ADDRESS_2 = 4
  ZIP_CODE = 5
  CITY = 6
  COUNTRY = 7
  PHONE = 8
  DATE_START = 9
  DATE_END = 10
  STATUS = 11

  def initialize(file)
    @file = file
    @addresses = []
    @errors = []
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        address = Address.find_or_initialize_by(id: row[ADDRESS_ID])

        address.addressable_id = row[INSTITUTION_ID]
        address.business_name = row[BUSINESS_NAME]
        address.address_1 = row[ADDRESS_1]
        address.address_2 = row[ADDRESS_2]
        address.zip_code = row[ZIP_CODE]
        address.city = row[CITY]
        address.country = row[COUNTRY]
        address.phone = row[PHONE]
        address.date_start = row[DATE_START]
        address.date_end = row[DATE_END]
        address.status = row[STATUS] if %w(archived active).include?(row[STATUS])
        address.addressable_type = 'Institution'

        @addresses << address
      end
    end

    if @addresses.map(&:valid?).all?
      @addresses.each(&:save!)
      true
    else
      @addresses.each_with_index do |address, index|
        @errors << "Ligne #{index+1}: #{address.errors.full_messages.join(', ')}" if address.errors.full_messages.present?
      end
      @errors.join('; ')
    end
  end
end

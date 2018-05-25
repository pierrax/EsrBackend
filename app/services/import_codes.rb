require 'csv'
class ImportCodes

  CODE_ID = 0
  INSTITUTION_ID = 1
  CONTENT = 2
  CODE_CATEGORY_ID = 3
  DATE_START = 4
  DATE_END = 5
  STATUS = 6

  def initialize(file)
    @file = file
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        code = Code.find_or_initialize_by(id: row[CODE_ID])

        code.institution_id = row[INSTITUTION_ID].to_i
        code.content = row[CONTENT]
        code.code_category_id = row[CODE_CATEGORY_ID].to_i
        code.date_start = row[DATE_START]
        code.date_end = row[DATE_END]
        code.status = row[STATUS] if %w(archived active).include?(row[DATE_END])

        p code.errors.messages unless code.save
      end
    end

    true
  end
end

require 'csv'
class ImportTaggings

  TAGGING_ID = 0
  INSTITUTION_ID = 1
  TAG_ID = 2
  DATE_START = 3
  DATE_END = 4
  STATUS = 5

  def initialize(file)
    @file = file
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        tagging = InstitutionTagging.find_or_initialize_by(id: row[TAGGING_ID])

        tagging.institution_id = row[INSTITUTION_ID].to_i
        tagging.institution_tag_id = row[TAG_ID].to_i
        tagging.date_start = row[DATE_START]
        tagging.date_end = row[DATE_END]
        tagging.status = row[STATUS] if %w(archived active).include?(row[STATUS])

        p tagging.errors.messages unless tagging.save
      end
    end

    true
  end
end

require 'csv'
class ImportLinks

  LINK_ID = 0
  INSTITUTION_ID = 1
  CONTENT = 2
  LINK_CATEGORY_ID = 3
  DATE_START = 4
  DATE_END = 5
  STATUS = 6

  def initialize(file)
    @file = file
    @links = []
    @errors = []
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        link = Link.find_or_initialize_by(id: row[LINK_ID])

        link.institution_id = row[INSTITUTION_ID].to_i
        link.content = row[CONTENT]
        link.link_category_id = row[LINK_CATEGORY_ID].to_i
        link.date_start = row[DATE_START]
        link.date_end = row[DATE_END]
        link.status = row[STATUS] if %w(archived active).include?(row[DATE_END])

        @links << link
      end
    end

    if @links.map(&:valid?).all?
      @links.each(&:save!)
      true
    else
      @links.each_with_index do |link, index|
        @errors << "Ligne #{index+1}: #{link.errors.full_messages.join(', ')}" if link.errors.full_messages.present?
      end
      @errors.join('; ')
    end
  end
end

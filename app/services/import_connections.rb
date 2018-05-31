require 'csv'
class ImportConnections

  CONNECTION_ID = 0
  MOTHER_ID = 1
  DAUGHTER_ID = 2
  CONNECTION_CATEGORY_ID = 3
  DATE = 4

  def initialize(file)
    @file = file
    @connections = []
    @errors = []
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        connection = InstitutionConnection.find_or_initialize_by(id: row[CONNECTION_ID])

        connection.mother_id = row[MOTHER_ID].to_i
        connection.daughter_id = row[DAUGHTER_ID].to_i
        connection.institution_connection_category_id = row[CONNECTION_CATEGORY_ID].to_i
        connection.date = row[DATE]

        @connections << connection
      end
    end

    if @connections.map(&:valid?).all?
      @connections.each(&:save!)
      true
    else
      @connections.each_with_index do |connection, index|
        @errors << "Ligne #{index+1}: #{connection.errors.full_messages.join(', ')}" if connection.errors.full_messages.present?
      end
      @errors.join('; ')
    end
  end
end

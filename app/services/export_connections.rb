require 'csv'
class ExportConnections

  def initialize(collection)
    @connections = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id Mere Fille ConnectionCategoryID ConnectionCategory Date)

      @connections.each do |connection|
        csv << [connection.id,
                connection.mother_id,
                connection.daughter_id,
                connection.institution_connection_category_id,
                connection.category.title,
                connection.date]
      end
    end
  end
end

require 'csv'
class ExportCodes

  def initialize(collection)
    @codes = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id InstitutionID Content CodeCategoryID CodeCategory DateCreation DateFermeture Status)

      @codes.each do |code|
        csv << [code.id,
                code.institution_id,
                code.content,
                code.code_category_id,
                code.category.title,
                code.date_start,
                code.date_end,
                code.status]
      end
    end
  end
end

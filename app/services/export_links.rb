require 'csv'
class ExportLinks

  def initialize(collection)
    @links = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id InstitutionID Content LinkCategoryID LinkCategory DateCreation DateFermeture Status)

      @links.each do |link|
        csv << [link.id,
                link.institution_id,
                link.content,
                link.link_category_id,
                link.category.title,
                link.date_start,
                link.date_end,
                link.status]
      end
    end
  end
end

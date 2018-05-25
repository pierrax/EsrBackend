require 'csv'
class ExportTaggings

  def initialize(collection)
    @taggings = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id InstitutionID TagID DateCreation DateFermeture Status)

      @taggings.each do |tagging|
        csv << [tagging.id,
                tagging.institution_id,
                tagging.institution_tag_id,
                tagging.date_start,
                tagging.date_end,
                tagging.status]
      end
    end
  end
end

require 'csv'
class ExportTaggings

  def initialize(collection)
    @taggings = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id InstitutionID TagID Tag DateCreation DateFermeture Status)

      @taggings.each do |tagging|
        csv << [tagging.id,
                tagging.institution_id,
                tagging.institution_tag_id,
                tagging.institution_tag.short_label,
                tagging.date_start,
                tagging.date_end,
                tagging.status]
      end
    end
  end
end

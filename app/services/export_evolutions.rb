require 'csv'
class ExportEvolutions

  def initialize(collection)
    @evolutions = collection
  end

  def call
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Id Predecesseur Successeur EvolutionCategoryID EvolutionCategory Date)

      @evolutions.each do |evolution|
        csv << [evolution.id,
                evolution.predecessor_id,
                evolution.follower_id,
                evolution.institution_evolution_category_id,
                evolution.category.title,
                evolution.date]
      end
    end
  end
end

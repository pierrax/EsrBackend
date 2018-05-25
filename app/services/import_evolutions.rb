require 'csv'
class ImportEvolutions

  EVOLUTION_ID = 0
  PREDECESSOR_ID = 1
  FOLLOWER_ID = 2
  EVOLUTION_CATEGORY_ID = 3

  def initialize(file)
    @file = file
  end

  def call
    csv_text = File.read(@file)
    CSV.parse(csv_text, col_sep: ';', headers: true).each do |row|
      if row
        evolution = InstitutionEvolution.find_or_initialize_by(id: row[EVOLUTION_ID])

        evolution.predecessor_id = row[PREDECESSOR_ID].to_i
        evolution.follower_id = row[FOLLOWER_ID].to_i
        evolution.institution_evolution_category_id = row[EVOLUTION_CATEGORY_ID].to_i

        p evolution.errors.messages unless evolution.save
      end
    end

    true
  end
end

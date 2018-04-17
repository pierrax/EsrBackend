class CreateInstitutionEvolutionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_evolution_categories do |t|
      t.string :title
      t.timestamps
    end
  end
end

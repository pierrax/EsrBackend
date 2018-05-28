class AddSynonymToInstitutions < ActiveRecord::Migration[5.1]
  def change
    add_column :institutions, :synonym, :text
  end
end

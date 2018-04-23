class CreateInstitutionConnectionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_connection_categories do |t|
      t.string :title
      t.timestamps
    end
  end
end

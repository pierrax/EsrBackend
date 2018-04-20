class CreateInstitutionTagCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_tag_categories do |t|
      t.string :title
      t.string :origin

      t.timestamps
    end
  end
end

class CreateInstitutionCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_categories do |t|
      t.references :institution
      t.integer :institution_category_label_id
      t.date :date_start
      t.date :date_end
      t.integer :status, default: 1

      t.timestamps
    end

    add_index :institution_categories, :institution_category_label_id
  end
end

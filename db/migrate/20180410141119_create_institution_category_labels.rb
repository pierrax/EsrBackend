class CreateInstitutionCategoryLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_category_labels do |t|
      t.string :short_label
      t.string :long_label
      t.timestamps
    end
  end
end

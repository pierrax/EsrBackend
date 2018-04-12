class CreateCodeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :code_categories do |t|
      t.string :title
      t.timestamps
    end
  end
end

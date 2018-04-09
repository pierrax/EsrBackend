class CreateCategoryLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :category_links do |t|
      t.string :title
      t.timestamps
    end
  end
end

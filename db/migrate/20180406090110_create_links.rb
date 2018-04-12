class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.references :institution
      t.string :content
      t.integer :link_category_id
      t.date :date_start
      t.date :date_end
      t.integer :status, default: 1

      t.timestamps
    end

    add_index :links, :link_category_id
  end
end

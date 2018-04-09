class CreateCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :codes do |t|
      t.references :institution
      t.string :content
      t.integer :category_code_id
      t.date :date_start
      t.date :date_end
      t.integer :status, default: 1

      t.timestamps
    end
  end
end

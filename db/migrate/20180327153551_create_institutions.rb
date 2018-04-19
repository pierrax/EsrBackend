class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end

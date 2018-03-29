class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end
  end
end

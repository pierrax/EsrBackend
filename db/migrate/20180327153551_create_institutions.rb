class CreateInstitutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institutions do |t|
      t.string :esr_id
      t.datetime :date_start
      t.datetime :date_end

      t.timestamps
    end

    add_index :institutions, :esr_id
  end
end

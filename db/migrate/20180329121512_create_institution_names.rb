class CreateInstitutionNames < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_names do |t|
      t.references :institution, index: true
      t.integer :status, default: 1
      t.string :text
      t.string :initials
      t.date :date_start
      t.date :date_end

      t.timestamps
    end
  end
end

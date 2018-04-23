class CreateInstitutionConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_connections do |t|
      t.integer :mother_id
      t.integer :daughter_id
      t.integer :institution_connection_category_id
      t.date :date

      t.timestamps
    end

    add_index :institution_connections, :mother_id
    add_index :institution_connections, :daughter_id
  end
end

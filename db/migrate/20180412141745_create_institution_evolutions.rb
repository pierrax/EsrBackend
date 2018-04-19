class CreateInstitutionEvolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_evolutions do |t|
      t.integer :predecessor_id
      t.integer :follower_id
      t.integer :institution_evolution_category_id
      t.date :date

      t.timestamps
    end

    add_index :institution_evolutions, :predecessor_id
    add_index :institution_evolutions, :follower_id
    add_index :institution_evolutions, [:follower_id, :predecessor_id], unique: true
  end
end

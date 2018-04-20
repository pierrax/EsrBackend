class CreateInstitutionTags < ActiveRecord::Migration[5.1]
  def change
    create_table :institution_tags do |t|
      t.string :short_label
      t.string :long_label
      t.integer :institution_tag_category_id

      t.date :date_start
      t.date :date_end
      t.integer :status, default: 1
      t.timestamps
    end

    add_index :institution_tags, :institution_tag_category_id

    create_table :institution_taggings, id: false do |t|
      t.belongs_to :institution, index: true
      t.belongs_to :institution_tag, index: true
    end
  end
end

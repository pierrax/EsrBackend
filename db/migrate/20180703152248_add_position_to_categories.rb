class AddPositionToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :code_categories, :position, :integer, default: 0
    add_column :institution_tag_categories, :position, :integer, default: 0
    add_column :link_categories, :position, :integer, default: 0
  end
end

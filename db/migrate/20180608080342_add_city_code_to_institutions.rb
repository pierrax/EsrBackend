class AddCityCodeToInstitutions < ActiveRecord::Migration[5.1]
  def change
    add_column :institutions, :size_range, :string
    add_column :addresses, :city_code, :integer
  end
end

class AddAllNewFieldsToIndividuals < ActiveRecord::Migration[7.1]
  def change
    add_column :individuals, :hit_area, :string
    add_column :individuals, :damaged_parts, :string
    add_column :individuals, :blood_letting, :string
    add_column :individuals, :cooling, :string
    add_column :individuals, :travel_time, :string
  end
end

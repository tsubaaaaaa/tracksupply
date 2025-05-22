class AddProcessingDetailsToIndividuals < ActiveRecord::Migration[7.1]
  def change

    add_column :individuals, :age_in_months, :integer
    add_column :individuals, :weight, :decimal, precision: 5, scale: 2
    add_column :individuals, :disassembling_date, :date
    add_column :individuals, :processing_date, :date
    add_column :individuals, :processing_facility, :string
    add_column :individuals, :processor_name, :string
  end
end

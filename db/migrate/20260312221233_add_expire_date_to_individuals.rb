class AddExpireDateToIndividuals < ActiveRecord::Migration[7.1]
  def change
    add_column :individuals, :expire_date, :date
  end
end

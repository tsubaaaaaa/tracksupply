class AddExpireDateToInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :expire_date, :date
  end
end

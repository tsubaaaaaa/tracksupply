class CreateShipments < ActiveRecord::Migration[7.1]
  def change
    create_table :shipments do |t|
      t.integer :user_id
      t.date :ship_date
      t.string :customer
      t.string :item
      t.string :status

      t.timestamps
    end
  end
end

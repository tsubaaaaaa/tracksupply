class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :part, null: false #部位
      t.decimal :weight
      t.string :status, null: false, default: "stocked" #初期値は　”入庫済”
      t.boolean :available
      
      t.references :individual, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end

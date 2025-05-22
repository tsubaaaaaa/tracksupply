class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:groups) # ★ この行を追加
      create_table :groups do |t|
        t.string :name, null: false
        t.text :description

        t.timestamps
      end
    end
  end
end

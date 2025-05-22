class CreateIndividuals < ActiveRecord::Migration[7.1]
  def change
    create_table :individuals do |t|
      t.string :identification_id
      t.date :hunt_date
      t.string :origin
      t.string :species
      t.string :method
      t.timestamps

      # Foreign key to the users table
      # Usersからの外部キーで捕獲者を特定
      t.references :user, null: false, foreign_key: true 

    end
  end
end

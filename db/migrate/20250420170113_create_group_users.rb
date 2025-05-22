class CreateGroupUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role, null: false, default: "member" # Default role is "member"

      t.timestamps

    end

    add_index :group_users, [:user_id, :group_id], unique: true

  end
end

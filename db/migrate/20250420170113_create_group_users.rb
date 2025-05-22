class CreateGroupUsers < ActiveRecord::Migration[7.1]
  def change
    unless table_exists?(:group_users)
      create_table :group_users do |t|
        t.references :user, null: false, foreign_key: true
        t.references :group, null: false, foreign_key: true
        t.string :role, null: false, default: "member" # Default role is "member"

        t.timestamps

      end
    end

    index_name = "index_group_users_on_user_id_and_group_id" # エラーメッセージから正確な名前を取得
    unless index_exists?(:group_users, [:user_id, :group_id], name: index_name, unique: true)
      add_index :group_users, [:user_id, :group_id], name: index_name, unique: true
    end

  end
end

# db/migrate/YYYYMMDDHHMMSS_change_user_id_null_constraint_on_inventories.rb
class ChangeUserIdNullConstraintOnInventories < ActiveRecord::Migration[7.1]
  def change
    change_column_null :inventories, :user_id, true # nullを許可する
    change_column_null :inventories, :group_id, true # デフォルト値をnilに設定
  end
end
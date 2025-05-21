class Group < ApplicationRecord

  # グループは複数のユーザーを持つ
  has_many :group_users
  has_many :users, through: :group_users

  #複数の在庫情報を持つ
  has_many :inventories, dependent: :destroy

end

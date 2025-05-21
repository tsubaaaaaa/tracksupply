class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザーは複数の個体情報を持つ
  has_many :individuals, dependent: :destroy

  # ユーザーは複数の在庫情報を持つ
  has_many :inventories, dependent: :destroy

  #ユーザーは複数のグループに所属する
  has_many :group_users
  has_many :groups, through: :group_users
  
  # 管理者権限を持つかどうかを判定するメソッド
  def admin?
    role == "admin"
  end

end

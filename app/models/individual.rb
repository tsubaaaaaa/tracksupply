class Individual < ApplicationRecord

  
  #個体情報は1人のユーザーに紐づく
  belongs_to :user

  has_many :inventories, inverse_of: :individual, dependent: :destroy
  accepts_nested_attributes_for :inventories, allow_destroy: true
  #個体情報
  
  #捕獲者の名前はuser.nameで取得
  def hunter_name
    user.name
  end
  
end

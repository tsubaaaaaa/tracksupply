class Individual < ApplicationRecord
  #個体情報は1人のユーザーに紐づく
  belongs_to :user

  #捕獲者の名前はuser.nameで取得
  def hunter_name
    user.name
  end
  
end

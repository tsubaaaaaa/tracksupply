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
  
  #トークンを生成
  before_create :generate_token

  private

  def generate_token
    # self.token = SecureRandom.hex(16) # 32文字のランダムな16進数文字列を生成
    # もし、生成したトークンが偶然にも既に使用されていたら、再度生成する
    self.token = loop do
      random_token = SecureRandom.hex(16)
      break random_token unless Individual.exists?(token: random_token)
    end
  end

  
  #keyword
  scope :search_by_keyword, ->(keyword) {
    return all if keyword.blank?

    individual_columns = [
      "identification_id",
      "origin",
      "species",
      "method",
      "processing_facility"
    ]

      # 部位情報の検索対象カラム
    inventory_columns = ["part"]

    individual_conditions = individual_columns.map do |column|
      "individuals.#{column} LIKE :keyword"
    end

    inventory_conditions = inventory_columns.map do |column|
      "inventories.#{column} LIKE :keyword"
    end

    conditions = (individual_conditions + inventory_conditions).join(" OR ")

    left_joins(:inventories)
    .where(conditions, keyword: "%#{sanitize_sql_like(keyword)}%")
    .distinct
  }


end

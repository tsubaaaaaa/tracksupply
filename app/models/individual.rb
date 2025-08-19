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

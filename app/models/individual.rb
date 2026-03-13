class Individual < ApplicationRecord

  
  #個体情報は1人のユーザーに紐づく
  belongs_to :user

  has_many :inventories, inverse_of: :individual, dependent: :destroy
  accepts_nested_attributes_for :inventories, allow_destroy: true
  #個体情報
  after_save :set_default_expire_date, if: :saved_change_to_expire_date?
  
  #捕獲者の名前はuser.nameで取得
  def hunter_name
    user.name
  end



  before_save :set_default_expire_date

  private

  def set_default_expire_date
        return unless expire_date.present?

    inventories.each do |inventory|
      # 【優先判定】
      # 今回の保存で、部位の賞味期限が手動で変更されている場合は
      # 親との同期（上書き）をスキップする
      next if inventory.saved_change_to_expire_date?

      # 手動変更がない部位のみ、個体と同じ賞味期限を適用
      # update_columns でバリデーションをスキップし、高速にDBを書き換える
      inventory.update_columns(expire_date: self.expire_date)
    end
  end

  
  #トークンを生成
  before_create :generate_token

  private

  #def update_inventories_expire_date
    #return unless processing_date.present?

    #inventories.each do |inventory|
      # 【優先処理の判定】
      # この保存処理の中で、この在庫の賞味期限（expire_date）が直接変更されていた場合は
      # 加工日連動の自動計算をスキップして、手動入力を優先する
     #next if inventory.saved_change_to_expire_date?

      # 手動変更がない在庫だけ、新しい加工日の1年後に更新
      # update_columnsを使うことで、Inventory側のバリデーションやコールバックを
      # スキップして高速に書き換えます
      #inventory.update_columns(expire_date: processing_date + 1.year)
    #end
  #end

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

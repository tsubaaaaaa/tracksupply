class Shipment < ApplicationRecord
  has_many :shipment_inventories, dependent: :destroy
  has_many :inventories, through: :shipment_inventories

  belongs_to :user # 出荷担当者など

  validates :customer, presence: true
  validates :ship_date, presence: true
end
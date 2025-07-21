class Inventory < ApplicationRecord
  belongs_to :individual
  belongs_to :user
  #belongs_to :group

  has_many :shipment_inventories, dependent: :destroy
  has_many :shipments, through: :shipment_inventories


  validates :part, presence: false
  validates :weight, 
            presence: false, 
            numericality: { 
              greater_than_or_equal_to: 0,
              allow_blank: true
            }

  before_validation :set_user_from_individual, on: :create

  private

  def set_user_from_individual
    if individual.present? && user_id.blank?
      self.user_id = individual.user_id
    end
  end


end
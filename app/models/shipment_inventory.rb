class ShipmentInventory < ApplicationRecord
  belongs_to :shipment
  belongs_to :inventory
end

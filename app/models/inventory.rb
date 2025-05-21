class Inventory < ApplicationRecord
  belongs_to :individual
  belongs_to :user
  belongs_to :group
end

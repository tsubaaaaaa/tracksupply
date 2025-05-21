class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.includes(:individual)
                             .where(user: current_user)
                             .order(updated_at: :desc)
  end
end

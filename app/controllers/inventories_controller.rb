class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.includes(:individual)
                             .where(user: current_user)
                             .order(updated_at: :desc)
  end

  def new
    @inventories = Inventories.new
  end

  private

  def inventories_params
    params.require(:inventories).permit(
      :part,
      :weight, 
      status: :stocked,
    )
  end

end

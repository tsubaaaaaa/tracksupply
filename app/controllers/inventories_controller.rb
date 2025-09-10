class InventoriesController < ApplicationController
  def new
    @inventories = Inventories.new
  end

  def index
    # まず、ログインしているユーザーの在庫を基本セットとして準備
    @inventories = Inventory.where(user_id: current_user.id)

    # もし検索キーワード(params[:query])が送られてきたら、絞り込みを追加
    if params[:keyword].present?
      @inventories = @inventories.where("part LIKE ?", "%#{params[:keyword]}%")
    end

    # 最後に並び替え
    @inventories = @inventories.order(updated_at: :desc)

    # これで、検索フォームから params[:query] 付きで /inventories にアクセスすれば
    # 検索結果が表示され、params[:query] がなければ全件表示される
  end

  def find_by_barcode
    # スキャンされたバーコードから在庫を検索
    inventory = Inventory.find_by(id: params[:barcode], status: 'stocked')
    if inventory 
      render json: {
        id: inventory.id,
        part: inventory.part,
        weight: inventory.weight
    }
    else
      render json: { error: '在庫が見つからないか出荷済です' }, status: :not_found
    end
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

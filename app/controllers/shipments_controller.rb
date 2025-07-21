class ShipmentsController < ApplicationController

  def index
    @shipments = Shipment.where(user_id: current_user.id)
    #@shipments = Shipment.includes(:inventories)
    #                     .where(user: current_user)
    #                     .order(updated_at: :desc) 
  end

def create
  # shipment_params で顧客名、出荷日、そして選択された在庫ID (inventory_ids) を一度に受け取る
  @shipment = current_user.shipments.build(shipment_params)

  if @shipment.save
    # ↑ この .save が成功した時点で、shipment と inventories の関連付けが
    #   中間テーブル (shipment_inventories) に自動的に保存されます！

    # 在庫のステータス更新処理
    # 関連付けられた在庫 (inventory_ids) のステータスを 'shipped' に一括更新
    Inventory.where(id: @shipment.inventory_ids).update_all(status: 'shipped')
    
    # 成功したら、作成された出荷の詳細ページにリダイレクト
    redirect_to @shipment, notice: '出荷情報を登録しました！'
  else
    # 保存に失敗したら、newテンプレートを再表示するために必要な変数を準備
    @individuals = Individual.order(:identification_id)
    render :new, status: :unprocessable_entity
  end
end



  def new
    @shipment = Shipment.new
    # 出荷可能な在庫（例：ステータスが 'stocked' のもの）を全て取得してビューに渡す
    
    @available_inventories = Inventory.where(status: 'stocked')
    @individuals = Individual.joins(:inventories)
                         .where(user_id: current_user.id, inventories: { status: 'stocked' })
                         .distinct
                         .order(:identification_id)

  end

  def show
    # 関連するinventories、各inventoryのindividual、shipmentのuserも一緒に読み込む
    @shipment = Shipment.includes(inventories: :individual, user: []).find(params[:id])
    @shipment_inventories = @shipment.inventories

  end

  def comment
    
  end

  private

  def shipment_params
    # :inventory_ids は配列で受け取るので [] を付ける
    params.require(:shipment).permit(:customer, :ship_date, inventory_ids: [])
  end

  
end

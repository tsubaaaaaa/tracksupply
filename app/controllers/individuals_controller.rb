class IndividualsController < ApplicationController

  def index
    @individuals = Individual.where(user_id: current_user.id)
    #@individuals = Individual.includes(:inventories)
                              #.where(user: current_user)
                             # .order(updated_at: :desc
                             
    
  end

  def show
    @individual = Individual.find(params[:id])
  end

  def new
    @individual = Individual.new
    @individual.inventories.build # 新しいインベントリを作成
  end

  def create
    @individual = Individual.new(individual_params)
    if @individual.save
      redirect_to individuals_path, notice: '個体情報が登録されました。'

    else
      render :new, status: :unprocessable_entity

    end
  end

  def edit
    @individual = Individual.find(params[:id])
    # 必要であれば、既存の inventories がない場合に空の入力欄を初期表示するために build する
    @individual.inventories.build if @individual.inventories.empty?
  end

  def update
    @individual = Individual.find(params[:id])
    if @individual.update(individual_params) # individual_params は create と同じものが使えることが多い
      redirect_to @individual, notice: '個体情報と部位情報が正常に更新されました。'
    else
      # エラー時に再度 inventories をビルドする必要がある場合がある (new アクションと同様)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @individual = Individual.find(params[:id])
    @individual.destroy
    redirect_to individuals_path, notice: '個体情報が削除されました。'
  end
  
    def inventories
      individual = Individual.find(params[:id])
      # "stocked" 状態の在庫に絞り込む
      @available_inventories = individual.inventories.where(status: 'stocked')
      render json: @available_inventories.select(:id, :part, :weight)
    end


  private
  def individual_params
    params.require(:individual).permit(
      :identification_id, # 個体識別ID
      :user_id, # ユーザーID
      :hunt_date, # 狩猟日
      :origin, # 産地
      :species, # 種類
      :method,  # 捕獲方法
      :age_in_months, # 月齢
      :weight, # 体重
      :disassembling_date, # 解体日
      :processing_date, # 処理日
      :processing_facility, # 処理施設
      :processor_name, # 処理者名
      :hit_area, # ヒットエリア
      :damaged_parts, # 損傷部位
      :blood_letting, # 放血の有無
      :cooling, # 運搬時冷蔵の有無
      :travel_time, # 運搬時間
      
      inventories_attributes: [:id, :part, :weight, :_destroy]

    )
  end

end
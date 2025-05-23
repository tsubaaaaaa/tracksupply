class IndividualsController < ApplicationController

  def index
    @individuals = Individual.where(user_id: current_user.id)
    #@individuals = Individual.includes(:inventories)
                              #.where(user: current_user)
                             # .order(updated_at: :desc)
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
  


  private
  def individual_params
    params.require(:individual).permit(
      :identification_id,
      :user_id,
      :hunt_date,
      :origin,
      :species,
      :method,
      :age_in_months,
      :weight,
      :disassembling_date,
      :processing_date,
      :processing_facility,
      :processor_name,
      
      inventories_attributes: [:id, :part, :weight, :_destroy]

    )
  end

end
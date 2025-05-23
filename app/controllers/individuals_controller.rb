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
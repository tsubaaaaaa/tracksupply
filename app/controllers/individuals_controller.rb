class IndividualsController < ApplicationController

  def index
    @individuals = Individual.all
    #@individuals = Individual.includes(:inventories)
                              #.where(user: current_user)
                             # .order(updated_at: :desc)
  end

  def show
    @individual = Individual.find(params[:id])
  end

  def register
    @individual = Individual.new
  end

  def create
    @individual = Individual.new(individual_params)
    if @individual.save
      redirect_to individuals_details_path, notice: '個体情報が登録されました。'

    else
      render :register
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
      :method
    )
  end

end
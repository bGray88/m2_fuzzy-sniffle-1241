class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    @dish = Dish.find_by(id: params[:dish_id])
    if @dish.present?
      @chef.dishes << @dish
    else
      flash[:alert] = "Error: Dish ID Must Exist"
    end

    redirect_to chef_path(@chef)
  end
end
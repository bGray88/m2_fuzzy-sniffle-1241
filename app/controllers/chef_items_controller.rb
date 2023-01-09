class ChefItemsController < ApplicationController
  def index
    @chef = Chef.find(params[:chef_id])
    @chef_items = Ingredient.ingredients_in_dishes(@chef.dishes)
  end
end
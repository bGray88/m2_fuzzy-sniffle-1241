class ChefItemsController < ApplicationController
  def index
    @chef = Chef.find(params[:chef_id])
    @chef_items = dishes_items
  end
end
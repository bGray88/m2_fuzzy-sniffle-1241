require 'rails_helper'

RSpec.describe 'dishes show page' do
  before(:each) do
    @chef_1 = Chef.create!(name: "Wolfgang")
    @dish_1 = Dish.create!(name: "Lobster Bisque", description: "Bold saucy ocean insect", chef: @chef_1)
    @ingredient_lobster = Ingredient.create!(name: "Lobster", calories: 500)
    @ingredient_soupbase = Ingredient.create!(name: "Soup", calories: 1000)
  end

  describe 'As a visitor, show page, lists dish\’s name and description' do
    it 'shows a list of ingredients, total calorie count, and chef\'s name for the dish.' do
      visit dish_path(@dish_1)

      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@chef_1.name)
      expect(page).to have_content(@ingredient_soupbase.name)
      expect(page).to have_content(@ingredient_lobster.name)
    end
  end
end
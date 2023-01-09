require 'rails_helper'

RSpec.describe 'chefs show page' do
  before(:each) do
    @chef_1 = Chef.create!(name: "Wolfgang")
    @chef_2 = Chef.create!(name: "Ming Sae")
    @dish_1 = Dish.create!(name: "Lobster Bisque", description: "Bold saucy ocean insect", chef: @chef_1)
    @dish_2 = Dish.create!(name: "Ham Sandwich", description: "Hard adn stale", chef: @chef_1)
    @dish_3 = Dish.create!(name: "Cheese Pizza", description: "Could be a frisby", chef: @chef_2)
    @dish_4 = Dish.create!(name: "Quesidilla", description: "Decent", chef: @chef_1)
    @ingredient_lobster = Ingredient.create!(name: "Lobster", calories: 500)
    @ingredient_soupbase = Ingredient.create!(name: "Soup", calories: 1000)
    @ingredient_cheese = Ingredient.create!(name: "Cheese", calories: 1500)
    @ingredient_ham = Ingredient.create!(name: "Ham", calories: 2000)
    @ingredient_bread = Ingredient.create!(name: "Bread", calories: 1000)
    @ingredient_tortilla = Ingredient.create!(name: "Tortilla", calories: 800)

    @dish_1.ingredients << @ingredient_lobster
    @dish_1.ingredients << @ingredient_soupbase
    @dish_2.ingredients << @ingredient_bread
    @dish_2.ingredients << @ingredient_ham
    @dish_3.ingredients << @ingredient_bread
    @dish_3.ingredients << @ingredient_cheese
    @dish_4.ingredients << @ingredient_tortilla
    @dish_4.ingredients << @ingredient_cheese
  end

  describe 'As a visitor, show page, lists chef\’s name' do
    it 'shows a list of dishes' do
      visit chef_path(@chef_1)

      expect(page).to have_content(@chef_1.name)
      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@dish_2.name)
      expect(page).to have_content(@dish_4.name)
    end

    it 'has a form to add an existing dish' do
      visit chef_path(@chef_1)

      expect(page).to have_field('dish_id')

      fill_in('dish_id', with: @dish_3.id)
      click_on('Add Dish')

      expect(current_path).to eq(chef_path(@chef_1))
      expect(page).to have_content(@dish_3.name)

      click_on('Add Dish')

      expect(page).to have_content("Error")
      expect(current_path).to eq(chef_path(@chef_1))
    end

    it 'has a link to view a list of all ingredients that this chef uses in their dishes' do
      visit chef_path(@chef_1)

      expect(page).to have_link("Used Ingredients")

      click_on("Used ingredients")
      
      expect(current_path).to eq(chef_ingredients_path(@chef_1))
    end
  end
end
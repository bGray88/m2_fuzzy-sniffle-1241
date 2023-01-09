require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :calories}
  end
  describe "relationships" do
    it {should have_many :dishes}
  end

  describe 'instance methods' do
    before(:each) do
      @chef_1 = Chef.create!(name: "Wolfgang")
      @dish_1 = Dish.create!(name: "Lobster Bisque", description: "Bold saucy ocean insect", chef: @chef_1)
      @ingredient_lobster = Ingredient.create!(name: "Lobster", calories: 500)
      @ingredient_soupbase = Ingredient.create!(name: "Soup", calories: 1000)
      @ingredient_onions = Ingredient.create!(name: "Soup", calories: 20)

      @dish_1.ingredients << @ingredient_lobster
      @dish_1.ingredients << @ingredient_soupbase
    end

    describe '#ingredients_in_dishes' do
      it 'returns all ingredients for a dish' do
        expect(Ingredient.ingredients_in_dishes(@dish_1)).to eq([@ingredient_lobster, @ingredient_soupbase])

        @dish_1.ingredients << @ingredient_onions

        expect(@dish_1.total_calories).to eq(1520)
      end
    end
  end
end
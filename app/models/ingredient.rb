class Ingredient < ApplicationRecord
  validates_presence_of :name, :calories
  has_many :dishes

  def self.ingredients_in_dishes(dishes)
    self.where(dish_id: dishes).distinct
  end
end
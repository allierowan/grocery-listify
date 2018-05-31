require "grocery_list"

class Recipe < ApplicationRecord
  has_many :ingredients, as: :parent_list
  validates :name, presence: true, length: { maximum: 200 }

  def add_all_ingredients_to(grocery_list_id)
    grocery_list = ::GroceryList.find_by(id: grocery_list_id)
    self.ingredients.each do |ingredient|
      grocery_ingredient = ingredient.dup
      grocery_list.ingredients << grocery_ingredient
      grocery_list.save
    end
    grocery_list.consolidate_ingredients!
    grocery_list.save
  end
end

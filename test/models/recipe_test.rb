require 'test_helper'
require 'pry'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "can copy and add all ingredients from a recipe to a grocery list" do
    recipe = recipes(:one)
    grocery_list = grocery_lists(:one)
    recipe.add_all_ingredients_to(grocery_list.id)
    assert_equal grocery_list.ingredients.length, 3
    assert_equal Ingredient.where(name: "Peanuts").length, 2
  end
end

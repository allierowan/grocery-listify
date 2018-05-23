require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipe_ingredients_path(recipes(:one).id)
    assert_response :success
  end

  test "should be able to create ingredient" do
    post recipe_ingredients_path(recipes(:one).id), params: { ingredient: { name: "Oranges", quantity: 5 } }
    assert_response :redirect
    ingredient = Ingredient.find_by!(name: "Oranges")
    assert_equal("5", ingredient.quantity)
  end

  test "should be able to destroy ingredient" do
    ingredient = ingredients(:one)
    delete recipe_ingredient_path(recipes(:one).id, ingredient.id)
    assert_response :redirect
    refute Ingredient.find_by(id: ingredient.id)
  end

end

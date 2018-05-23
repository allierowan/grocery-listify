require 'test_helper'
require 'pry'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recipes_path
    assert_response :success
  end

  test "should get show" do
    get recipe_path(recipes(:one).id)
    assert_response :success
    assert_match(/Great Recipe/, response.body)
  end

  test "should get new form" do
    get new_recipe_path
    assert_response :success
  end

  test "should get edit form" do
    get edit_recipe_path(recipes(:one).id)
    assert_response :success
  end

  test "should be able to create recipe" do
    post recipes_path, params: { recipe: { name: "Allies Recipe", url: "hey.com" } }
    assert_response :ok
    recipe = Recipe.find_by!(name: "Allies Recipe")
    assert_equal("hey.com", recipe.url)
  end

  test "should be able to destroy recipe" do
    recipe = recipes(:one)
    delete recipe_path(recipe.id)
    assert_response :ok
    refute Recipe.find_by(id: recipe.id)
  end

  test "should be able to update recipe" do
    patch recipe_path(recipes(:one).id), params: { recipe: { name: "Great Recipe", url: "test.com"} }
    assert_response :ok
    assert_equal "Great Recipe", recipes(:one).name
    assert_equal "test.com", recipes(:one).url
  end

end

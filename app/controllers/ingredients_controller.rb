require 'pry'

class IngredientsController < ApplicationController
  def index
    @recipe = Recipe.find(params["recipe_id"])
    @ingredient = Ingredient.new()
    @ingredients = @recipe.ingredients
  end

  def show
    @ingredient = Ingredient.find(params["id"])
  end

  def new
    @recipe = Recipe.find(params["recipe_id"])
    @ingredient = Ingredient.new()
    render :new
  end

  def edit
    @ingredient = Ingredient.find(params["id"])
  end

  def create
    @recipe = Recipe.find(params["recipe_id"])
    @ingredient = @recipe.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to recipe_ingredients_path, flash: { success: "Ingredient created" }
    else
      @recipe = Recipe.find(params["recipe_id"])
      @ingredients = @recipe.ingredients
      render :index
    end
  end

  def destroy
    Ingredient.find(params["id"]).destroy
    redirect_to recipe_ingredients_path
  end

  def destroy_grocery_list_ingredient
    Ingredient.find(params["id"]).destroy
    redirect_to grocery_lists_path
  end

  def create_grocery_list_ingredient
    @grocery_list = GroceryList.first
    @ingredient = @grocery_list.ingredients.build(ingredient_params)
    if @ingredient.save
      redirect_to grocery_lists_path, flash: { success: "Ingredient created" }
    else
      redirect_to grocery_lists_path
    end
  end

  def update
    @ingredient = Ingredient.find(params["id"])
    if @ingredient.update(ingredient_params)
      if @ingredient.recipe
        redirect_to recipe_ingredients_path(@ingredient.recipe.id)
      else
        redirect_to grocery_lists_path
      end
    else
      @message = "Unable to save your ingredient"
    end
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity)
  end
end

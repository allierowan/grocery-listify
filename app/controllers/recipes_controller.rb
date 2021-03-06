require "pry"

class RecipesController < ApplicationController
  def index
    # there has to be a grocery list. check if one exists
    @grocery_list
    if GroceryList.count == 0
      @grocery_list = GroceryList.new({date: "Today"})
      @grocery_list.save
    else
      @grocery_list = GroceryList.first
    end
    @recipes = Recipe.all.reverse
  end

  def show
    @recipe = Recipe.find(params["id"])
  end

  def new
    @recipe = Recipe.new()
    render :new
  end

  def edit
    @recipe = Recipe.find(params["id"])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path, flash: { success: "Recipe created" }
    else
      render :index
    end
  end

  def destroy
    Recipe.find(params["id"]).destroy
    redirect_to recipes_path
  end

  def update
    @recipe = Recipe.find(params["id"])
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      @message = "Unable to save your recipe"
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :url)
  end

  def add_recipe_ingredients
    recipe = Recipe.find(params["id"])
    grocery_list = GroceryList.find(params["grocery_list_id"])
    recipe.add_all_ingredients_to(grocery_list.id)
    @recipes = Recipe.all.reverse
    @grocery_list = grocery_list
    render :index
  end
end

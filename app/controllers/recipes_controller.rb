class RecipesController < ApplicationController
  def index
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
      render :new
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
    render :index
  end
end

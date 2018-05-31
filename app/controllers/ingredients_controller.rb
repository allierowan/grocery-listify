require 'pry'

class IngredientsController < ApplicationController
  before_action :find_parent_list

  def index
    @ingredient = Ingredient.new()
    @ingredients = @parent_list.ingredients
  end

  def show
    @ingredient = Ingredient.find(params["id"])
  end

  def new
    @ingredient = Ingredient.new()
    render :new
  end

  def edit
    @ingredient = Ingredient.find(params["id"])
  end

  def create
    @ingredient = @parent_list.ingredients.build(ingredient_params)
    @ingredient.save
    redirect_to :controller => @parent_list.class.to_s.underscore.pluralize.downcase, action: :index, id: @parent_list.id
  end

  def destroy
    Ingredient.find(params["id"]).destroy
    redirect_to ingredients_path(params[:parent_list_type], params[:parent_list_id])
  end

  def update
    @ingredient = Ingredient.find(params["id"])
    if @ingredient.update(ingredient_params)
      redirect_to ingredients_path(@ingredient.parent_list_type, @ingredient.parent_list_id)
    else
      @message = "Unable to save your ingredient"
    end
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :unit)
  end

  private
  def find_parent_list
    @klass = params[:parent_list_type].camelize.constantize
    @parent_list = @klass.find(params[:parent_list_id])
  end
end

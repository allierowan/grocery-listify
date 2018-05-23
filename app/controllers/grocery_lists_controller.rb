class GroceryListsController < ApplicationController
  def index
    @grocery_lists = GroceryList.all.reverse
  end

  def show
    @grocery_list = GroceryList.find(params["id"])
  end

  def new
    @grocery_list = GroceryList.new()
    render :new
  end

  def edit
    @grocery_list = GroceryList.find(params["id"])
  end

  def create
    @grocery_list = GroceryList.new(grocery_list_params)
    if @grocery_list.save
      redirect_to grocery_lists_path, flash: { success: "GroceryList created" }
    else
      render :new
    end
  end

  def destroy
    GroceryList.find(params["id"]).destroy
    redirect_to grocery_lists_path
  end

  def update
    @grocery_list = GroceryList.find(params["id"])
    if @grocery_list.update(grocery_list_params)
      redirect_to grocery_lists_path
    else
      @message = "Unable to save your grocery_list"
    end
  end

  def grocery_list_params
    params.require(:grocery_list).permit(:date)
  end
end

class GroceryListsController < ApplicationController
  def index
    @grocery_list = GroceryList.first
    @ingredient = Ingredient.new()
  end

  def update
    @grocery_list = GroceryList.find(params["id"])
    if @grocery_list.update(grocery_list_params)
      redirect_to grocery_lists_path
    else
      @message = "Unable to save your grocery_list"
    end
  end

  def send_items_to_wunderlist
    success = GroceryList.first.send_to_wunderlist
    if success == "Success"
      @success_message = "sent all items to wonderlist!"
    else
      @message = success
    end
    @grocery_list = GroceryList.first
    @ingredient = Ingredient.new()
    render :index
  end

  def grocery_list_params
    params.require(:grocery_list).permit(:date)
  end
end

class AddGroceryListIdToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :grocery_list_id, :integer
  end
end

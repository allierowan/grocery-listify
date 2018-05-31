class MakeRecipeAndGroceryListIngredientable < ActiveRecord::Migration[5.2]
  def change
    add_reference :ingredients, :parent_list, polymorphic: true, index: true
    remove_column :ingredients, :recipe_id
    remove_column :ingredients, :grocery_list_id
  end
end

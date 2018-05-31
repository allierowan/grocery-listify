class ChangeQuantityToFloatFromIngredients < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :quantity
    add_column :ingredients, :quantity, :float
  end
end

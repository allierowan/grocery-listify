class RenameColumnDateToNameOnIngredients < ActiveRecord::Migration[5.2]
  def change
    rename_column :grocery_lists, :date, :name
  end
end

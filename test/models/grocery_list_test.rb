require 'test_helper'

class GroceryListTest < ActiveSupport::TestCase
  test "can consolidate same ingredients" do
    grocery_list = GroceryList.new({date: "Today"})
    grocery_list.ingredients.build({name: "Apples", unit: "lb", quantity: 5})
    grocery_list.ingredients.build({name: "Apples", unit: "lb", quantity: 2})
    grocery_list.save
    grocery_list.consolidate_ingredients!
    assert_equal(1, grocery_list.ingredients.length)
    assert_equal(7, grocery_list.ingredients.first.quantity)
    assert_equal("Apples", grocery_list.ingredients.first.name)
    assert_equal("lb", grocery_list.ingredients.first.unit)
  end
end

require 'test_helper'

class GroceryListsControllerTest < ActionDispatch::IntegrationTest
  test "can get index" do
    get grocery_lists_path
    assert_response :success
  end
end

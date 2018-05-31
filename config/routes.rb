Rails.application.routes.draw do
  resources :grocery_lists, only: [:index]
  resources :recipes, only: [:create, :edit, :update, :destroy, :index]
  resources :ingredients, path: "ingredients/:parent_list_type/:parent_list_id"

  # post "/ingredients/:parent_list_type/:parent_list_id", controller: :ingredients, action: :create, as: :ingredients
  # get "/ingredients/:parent_list_type/:parent_list_id", controller: :ingredients, action: :index
  post "/recipes/:id/grocery_lists/:grocery_list_id", controller: :recipes, action: :add_recipe_ingredients, as: :add_ingredients
  # delete "/recipes/:id/grocery_lists/:grocery_list_id/:id", controller: :recipes, action: :destroy, as: :ingredient

  post "/grocery_list/send_to_wunderlist", controller: :grocery_lists, action: :send_items_to_wunderlist, as: :post_to_wunderlist

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
end

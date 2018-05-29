Rails.application.routes.draw do
  resources :recipes, only: [:create, :edit, :update, :destroy, :index] do
    resources :ingredients, only: [:create, :destroy, :index]
  end

  resources :grocery_lists do
    resources :ingredients, only: [:index], action: :grocery_list_ingredients
  end

  resources :ingredients, only: [:edit, :update]

  post "recipes/:id/grocery_lists/:grocery_list_id", controller: :recipes, action: :add_recipe_ingredients, as: :add_ingredients
  delete "grocery_lists/:grocery_list_id/ingredients/:id", controller: :ingredients, action: :destroy_grocery_list_ingredient, as: :delete_grocery_list_ingredient
  post "grocery_lists/:grocery_list_id/ingredients", controller: :ingredients, action: :create_grocery_list_ingredient
  post "grocery_list/send_to_wunderlist", controller: :grocery_lists, action: :send_items_to_wunderlist, as: :post_to_wunderlist

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
end

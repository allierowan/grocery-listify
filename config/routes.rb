Rails.application.routes.draw do
  resources :recipes, only: [:create, :edit, :update, :destroy, :index] do
    resources :ingredients, only: [:create, :destroy, :index]
  end

  resources :grocery_lists do
    resources :ingredients, only: [:index, :destroy, :edit, :update, :create], action: :grocery_list_ingredients
  end

  post "recipes/:id/grocery_lists/:grocery_list_id", controller: :recipes, action: :add_recipe_ingredients, as: :add_ingredients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
end

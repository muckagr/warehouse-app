Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  resources :warehouses, only: [:show, :create, :edit, :new, :update, :destroy]
  resources :suppliers, only: [:index, :show, :create, :edit, :new, :update]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
  # Defines the root path route ("/")
  # root "articles#index"
end

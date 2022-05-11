Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  resources :warehouses, only: [:show, :create, :edit, :new, :update, :destroy]
  resources :suppliers, only: [:index, :show, :create, :edit, :new, :update]
  # Defines the root path route ("/")
  # root "articles#index"
end

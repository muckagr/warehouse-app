Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  resources :warehouses, only: [:show, :create, :edit, :new]
  # Defines the root path route ("/")
  # root "articles#index"
end

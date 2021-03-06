Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "articles#index"
  # Defines the root path route ("/")
  devise_for :users
  root to: 'home#index'
  
  resources :warehouses, only: [:show, :create, :edit, :new, :update, :destroy]
  resources :suppliers, only: [:index, :show, :create, :edit, :new, :update]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update]  do
    resources :order_items, only: %i[ new create]
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end
end

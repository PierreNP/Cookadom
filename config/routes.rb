Rails.application.routes.draw do
 
  get 'avatar/create'
  get 'avatar/destroy'

  root 'static_pages#home'
  
  resource :static_pages, only: [:home]
  
  resources :carts, only: [:show, :create, :update, :destroy]

  resources :order_dishes, only: [:create, :update, :destroy]

  resources :dishes, only: [:index, :show]
  
  resources :cooks, only: [:new, :create, :show, :destroy]
  
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :edit, :update, :destroy]

  namespace :admin, only: [:index, :update, :destroy] do
    resources :cooks, :users
  end

  namespace :cook, only: [:index, :create, :update, :destroy] do
    resources :dishes do 
      resources :photos, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
 
  root 'static_pages#home'
  
  resource :static_pages, only: [:home]
  
  resources :carts, only: [:create, :update, :destroy]
  
  resources :dishes
  resources :cooks, except: [:index]
  
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

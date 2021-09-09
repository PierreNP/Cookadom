Rails.application.routes.draw do
 
  get 'avatars/create'
  get 'avatars/destroy'
  get 'avatar/create'
  get 'avatar/destroy'
  get 'photos/create'
  get 'photos/destroy'
  root 'static_pages#home'
  
  resource :static_pages, only: [:home]
  
  resources :carts, only: [:show, :create, :update, :destroy]
  resources :order_dishes, only: [:create, :update, :destroy]
  resources :dishes do 
    resources :photos, only: [:create, :destroy]
  end
  resources :cooks, except: [:index]
  
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

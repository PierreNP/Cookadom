Rails.application.routes.draw do
 
  root 'static_pages#home'
  
  resource :static_pages, only: [:home]
  
  resources :carts, only: [:index, :update]

  resources :order_dishes, only: [:create, :update, :destroy]

  resources :dishes, only: [:index, :show] do 
    resources :ratings, only: [:new, :create, :show]
  end
  
  resources :cooks, only: [:new, :edit, :create, :show, :destroy] do 
    resources :avatars, only: [:create, :destroy]
  end
  
  devise_for :users, :controllers => { registrations: :registrations }
  resources :users, only: [:show, :edit, :update, :destroy] do 
    resources :addresses, only: [:create, :update, :destroy]
  end

  namespace :admin do
    resources :cooks, :users, only: [:update, :destroy]
    resources :dashboard_admins, only: [:index]
    resources :admin_dishes, only: [:destroy]
    resources :admin_comments, only: [:destroy]
  end

  namespace :cook, only: [:index, :create, :update, :destroy] do
    resources :dishes do 
      resources :photos, only: [:create, :destroy]
    end
    resources :carts, only: [:update, :destroy]
  end

  resources :comments, only: [:create, :update, :destroy]

  scope '/checkout' do
    post 'create', to: 'checkouts#create', as: 'checkout_create'
    get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkouts#success', as: 'checkout_success'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

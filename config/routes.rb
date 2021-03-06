Rails.application.routes.draw do
  root 'static_pages#home'
  get "/static_pages/home_cook" => "static_pages#home_cook"
  
  resource :static_pages, only: [:home, :home_cook]
  devise_for :users, :controllers => { registrations: :registrations }
  
  resources :carts, only: [:index, :update]
  resources :comments, only: [:create, :update, :destroy]
  resources :favorits, only: [:index, :create, :destroy]
  resources :order_dishes, only: [:create, :update, :destroy]

  resources :dishes, only: [:index, :show] do 
    resources :ratings, only: [:new, :create, :show]
  end
  
  resources :cooks, only: [:new, :edit, :create, :show, :destroy] do 
    resources :avatars, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update, :destroy] do 
    resources :addresses, only: [:create, :update, :destroy]
  end

  resources :conversations do
    resources :messages
  end

  namespace :admin do
    resources :cooks, :users, only: [:update, :destroy]
    resources :dashboard_admins, only: [:index]
    resources :admin_dishes, only: [:destroy]
    resources :admin_comments, only: [:destroy]
    resources :tags, only: [:create, :update, :destroy]
  end

  namespace :cook, only: [:index, :create, :update, :destroy] do
    resources :dishes do 
      resources :photos, only: [:create, :destroy]
    end
    resources :carts, only: [:update, :destroy]
  end

  namespace :user do
    resources :dishes, only: [:index]
  end
  


  scope '/checkout' do
    post 'create', to: 'checkouts#create', as: 'checkout_create'
    get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkouts#success', as: 'checkout_success'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
 
  root 'static_pages#home'
  resource :static_pages, only: [:home]
  
  resources :cooks, except: [:index]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

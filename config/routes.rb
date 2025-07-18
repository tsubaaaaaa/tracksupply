Rails.application.routes.draw do


  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path 
  root "homes#index"
  
  resources :users, only: [:index, :show] 

  #グループのルーティング
  resources :groups do
    resources :group_users, only: [:index, :create, :update, :destroy]
  end
    
  #個体情報のルーティング
  resources :individuals

  resources :individuals, only: [] do
    member do
      get :inventories
    end
  end

  #在庫情報のルーティング
  resources :inventories 

  #出荷情報のルーティング
  resources :shipments 

 


end

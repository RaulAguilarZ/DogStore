Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #devise_for :users
  #devise_for :admin_users, ActiveAdmin::Devise.config

  #ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  #get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  #get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

    #Routes Index and Show
    resources :products, only: [:index, :show]

    #
    resource :cart, only: [:show] do
      post 'add/:id', to: 'carts#add', as: 'add'
      delete 'remove/:id', to: 'carts#remove', as: 'remove'
      delete 'clear', to: 'carts#clear', as: 'clear'
      put 'update_quantity/:product_id', to: 'carts#update_quantity', as: 'update_quantity'
    end



    #resources :checkout, only: [:show, :create]

    # Routes contacts and abouts
    resources :contacts, only: [:new, :create]
    resources :abouts, only: [:index]

    # Ruta Index
    root 'products#index'
  end
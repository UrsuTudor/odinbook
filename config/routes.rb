Rails.application.routes.draw do
  get "comments/new"
  get "comments/create"
  devise_for :users
  resources :users, only: [ :index, :show, :edit, :update ] do
    member do
      post "accept_follow_request"
      post "reject_follow_request"
      delete "unfollow"
    end
  end

  resources :posts, only: [ :new, :create ]

  resources :follow_requests, only: [ :create ]

  resources :likes, only: [ :create, :destroy ]

  resources :comments, only: [ :create ]


  root to: "posts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end

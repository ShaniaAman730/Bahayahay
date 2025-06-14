Rails.application.routes.draw do

  get "realtor_signup/new"

  root "home#index"
  get '/home' => 'home#default_homepage'
  

  devise_for :users, controllers: {registrations: 'users/registrations' }
  resources :users, only: [:show]

  resources :user_management, only: [:index, :show, :new, :create, :edit, :update, :destroy] # Generates RESTful routes for users
  get'/managerealtors' => 'user_management#managerealtors'

  resources :dev_projects do
    get '/page/:page', action: :index, on: :collection
    member do
      delete :remove_attachment
    end
  end

  resources :model_houses do 
    member do
      delete :remove_attachment
    end
  end

  resources :realtor_signup, only: [:index, :new, :create]
  get 'thank_you_realtor', to: 'realtor_signup#thank_you_realtor'

  resources :listings do
    resources :reviews, only: [:new, :create]
    get '/page/:page', action: :index, on: :collection
    member do
      post :confirm
      get 'public'
      delete :remove_attachment
    end
  end
  get  '/select_type', to: 'listings#select_type'
  post '/choose_type', to: 'listings#choose_type', as: :choose_type_listings
  get  '/new_independent', to: 'listings#new_independent'
  get  '/new_project', to: 'listings#new_project'
  get '/public_listings', to: 'listings#public_listings'


  resources :conversations, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  namespace :admin do
  resources :listings, only: [:index, :show] do
    member do
      patch :approve
      patch :reject
    end
  end
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

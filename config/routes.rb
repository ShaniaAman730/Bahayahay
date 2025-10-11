Rails.application.routes.draw do

  get "agents/index"

  root "home#index"
  get '/home' => 'home#default_homepage'
  

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    member do
      get :statistics_data
      patch :approve
      patch :reject
      get :reviews
      get :review_events
    end
    collection do
      get :all_users
      get :managerealtors
    end
  end

  get "agents", to: "agents#index", as: :agents

  resources :dev_projects do
    get '/page/:page', action: :index, on: :collection
    member do
      get :statistics_data
      delete :remove_attachment
    end
  end

  resources :model_houses do 
    member do
      delete :remove_attachment
    end
  end

  resources :realtor_signup, only: [:index, :new, :create] do
    collection do
      get :search_brokers
      get :search_realties
    end
  end

  get 'thank_you_realtor', to: 'realtor_signup#thank_you_realtor'


  resources :listings do
    resources :reviews, only: [:new, :create, :destroy]
    get '/page/:page', action: :index, on: :collection
    post 'contact_agent', on: :member

    member do
      get :statistics_data
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

  get "notifications/unread_count", to: "notifications#unread_count"

  namespace :admin do
  resources :users, only: [:new, :create]

    resources :listings, only: [:index, :show, :destroy] do
      member do
        patch :approve
        patch :reject
      end
    end

    resources :realties, only: [:index, :show, :destroy] do
      member do
        patch :approve
        patch :reject 
      end
    end

    resources :rebap_memberships, only: [:index, :new, :create]
  end

  resources :guides do
    collection do
      get :my_guides
    end
    resources :comments, only: [:create]
  end

  resources :saved_listings, only: [:index, :create, :destroy]

  get "notifications/unread_count", to: "notifications#unread_count"

  resources :review_events, only: [] do
    member do
      patch :mark_as_read
    end
  end

 resources :realties do
  resources :realty_memberships, only: [:create, :update, :destroy] do
    member do
      patch :approve
      patch :reject
      patch :request_removal
      patch :approve_removal
      patch :reject_removal
      patch :force_remove
    end
  end

  resources :accreditations, only: [:create]

  member do
      get :edit_requirements
      patch :update_requirements
      get :manage_members
    end
  end

  resources :accreditations, only: [:update, :destroy] do
    collection do
      get :developer_requests
    end
  end

  resources :rebaps, only: [:show, :edit, :update] do
    collection do
      get :manage_members
      post :add_member
      delete :remove_member
      get :manage_officers
      patch :assign_officer
      delete :unassign_officer
    end
  end


  mount Importmap::Engine => "/rails/importmap"
  # mount ActionCable.server => '/cable'

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

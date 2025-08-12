Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :management do
    get "/" => "dashboard#index", as: :dashboard
    resources :events do
      resources :event_locations do
        resources :ticket_pools, except: [ :show ]
      end
    end
    resources :orders
    resources :messages
    resources :users
    resources :payments
    resources :clients
  end


  # Defines the root path route ("/")
  root "home#index"


  get "search", to: "search#index", as: "search_index"
  get "*categories", to: "categories#show", constraints: CategoryConstraint.new, as: "category_show"
  get "*categories/:event_slug", to: "events#show", constraints: EventConstraint.new, as: "event_show"
end

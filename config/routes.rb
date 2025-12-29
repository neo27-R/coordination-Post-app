Rails.application.routes.draw do
  root "events#index"

  get "home/top"

  resources :users, only: %i[new create]

  get "login",  to: "user_sessions#new",     as: :login
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy", as: :logout

  resources :events do
    resource :participation,
             only: %i[create destroy],
             module: :events
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end

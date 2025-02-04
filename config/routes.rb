Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  mount MissionControl::Jobs::Engine, at: "/jobs"

  # Defines the root path route ("/")
  root "starts#show"

  resource :start, only: [ :show, :new, :create ]
  resource :session, only: [ :new, :create, :destroy ]
  resource :registration, only: [ :new, :create ]
  resource :password_reset
  resource :password, only: [ :edit, :update ]
  resource :settings, only: [ :show ]
  resources :characters do
    post "activate", on: :member
  end

  # Teleporting
  resource :teleport, only: [ :new, :create ]

  # Add stats
  post "add_strength", to: "add_stats#strength"
  post "add_agility", to: "add_stats#agility"
  post "add_vitality", to: "add_stats#vitality"
  post "add_energy", to: "add_stats#energy"

  # Adventure (walk without teleport)
  resource :adventure, only: [ :show ] do
    post "travel"
  end

  resource :combat, only: [ :new, :create, :show ]

  resource :map, only: [ :show ]

  resource :teleport, only: [ :new, :create ]

  resources :monsters do
    post "receive_spell_damage", on: :member
    post "receive_attack_damage", on: :member
  end
end

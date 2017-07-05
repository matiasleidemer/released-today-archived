require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    resources :users
    resources :albums
    resources :artists
    resources :notifications

    root to: "users#index"
  end

  devise_for :users, controllers: { omniauth_callbacks: "spotify_callbacks" }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: "home#index"

  get "dashboard", to: "dashboard#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create]

      post "me/add_artists", to: "profile#add_artists"
      get  "me/releases",    to: "profile#releases"
      get  "me/artists",     to: "profile#artists"
    end
  end

  # Custom spotify swap/refresh tokens. Needed for iOS token generation
  post "spotify/tokens/swap", to: "spotify_tokens#swap"
  post "spotify/tokens/refresh", to: "spotify_tokens#swap"
end

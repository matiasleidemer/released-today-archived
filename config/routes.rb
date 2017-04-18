Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "spotify_callbacks" }

  root to: "home#index"

  get "dashboard", to: "dashboard#index"
end

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "spotify_callbacks" }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: "home#index"

  get "dashboard", to: "dashboard#index"

  mount API::Base, at: "/"
end

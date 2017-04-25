Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :albums
    resources :artists

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
    end
  end
end

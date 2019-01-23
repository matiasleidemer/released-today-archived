require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :admin do
    resources :users
    resources :albums
    resources :artists
    resources :notifications

    root to: 'users#index'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'spotify_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: 'home#index'

  get 'dashboard', to: 'dashboard#index'
  get 'preferences', to: 'preferences#index'
  put 'preferences', to: 'preferences#update'
end

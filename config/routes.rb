Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]
  resources :settings, only: [:index]
  resources :video_feeds, only: [:create, :update, :destroy]
  resources :pet_feeders, only: [:create, :update, :destroy]
end

Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/nest/callback', to: 'nest#create'
  get '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]
  resources :settings, only: [:index]
  resources :video_feeds, only: [:create, :update, :destroy]
  resources :pet_feeders, only: [:create, :update, :destroy] do
    resources :feed_times, only: [:create, :update, :destroy]
  end
  resources :nest, only: [:create, :destroy]
end

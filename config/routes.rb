Rails.application.routes.draw do
  root to: 'welcome#index'
  post '/login', to: 'sessions#create'
  get '/auth/nest/callback', to: 'nest#create'
  get '/logout', to: 'sessions#destroy'

  resources :dashboard, only: [:index]
  resources :settings, only: [:index]
  resources :video_feeds, only: [:create, :update, :destroy]
  resources :pet_feeders, only: [:create, :update, :destroy] do
    resources :feed_times, only: [:create, :update, :destroy]
  end
  resources :nest, only: [:create, :destroy]
  get '/pet_feeder/:id/feed', to: 'pet_feeders#feed', as: 'feed'
  resources :users, only: [:create, :destroy, :edit, :update]
end

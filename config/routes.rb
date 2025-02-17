Rails.application.routes.draw do
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  resources :users, only: [:create]
  resource :session, only: [:create, :destroy]
  resources :categories do
    resources :tasks
  end

  
  get "up" => "rails/health#show", as: :rails_health_check

  root "sessions#new"
end

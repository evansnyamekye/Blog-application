Rails.application.routes.draw do
  devise_for :users
  # get 'pages/hello'
  # root 'pages#hello'
  # root 'posts#index'
  #These are the routes for the users and posts controllers which are nested and also known as rourte definitions
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :destroy, :new, :show] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

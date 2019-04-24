Rails.application.routes.draw do

  root "homes#index"
  get "/index", to: "homes#index"
  get "/about", to: "homes#about"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :places, only: [:index, :show]

  resources  :posts do
    resources :comments, except: [:index]
    resources :reports, only: [:new, :create]
    resources :rates, except: [:index, :show]
  end

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/signin" , to: "sessions#new"
  post "/signin" , to: "sessions#create"

  delete "/log_out", to: "sessions#destroy"
  resources :accounts, only: [:edit]
  resources :relations, only: [:create, :destroy]
  resources :password_resets, except: [:index, :destroy]

  namespace :admin do
    root "dashboards#index"
    get "/index", to: "dashboards#index"
    resources :users
    resources :posts, only: [:index, :show, :destroy]

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/log_out", to: "sessions#destroy"

    resources :posts
    resources :places

    get "/charts", to: "charts#index"
  end
end

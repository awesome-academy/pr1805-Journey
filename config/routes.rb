Rails.application.routes.draw do
  root "homes#index"
  get "/index", to: "homes#index"
  get "/about", to: "homes#about"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources  :posts, except: :show

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/signin" , to: "sessions#new"
  post "/signin" , to: "sessions#create"

  delete "/log_out", to: "sessions#destroy"
  resources :accounts, only: [:edit]
  resources :relations, only: [:create, :destroy]
end

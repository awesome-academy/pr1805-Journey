Rails.application.routes.draw do
  root "homes#index"
  get "/index", to: "homes#index"
  get "/about", to: "homes#about"
end

Rails.application.routes.draw do
  root "home#index"

  get "/signup", to: "users#new"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, except: [:index, :new, :destroy]
  resources :projects, except: [:edit, :update, :destroy]
  
end
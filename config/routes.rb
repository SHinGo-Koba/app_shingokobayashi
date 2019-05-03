Rails.application.routes.draw do
  root "home#index"

  post "/search", to: "home#search"

  get "/signup", to: "users#new"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  
  resources :users, except: [:index, :new, :destroy]
  resources :projects, except: [:edit, :update, :destroy] do
    resources :tasks, only: [:new, :create]
  end
  
end
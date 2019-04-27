Rails.application.routes.draw do
  root "home#index"

  resources :users, except: [:index, :destroy]
  
end

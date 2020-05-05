Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "users#new", as: "new_user"
  post "/", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create", as: "sessions"
  post "/logout", to: "sessions#destroy"

  # get "/:user", to: "users#show", as: "homepage"
  resources :planes, only: [:index, :show]
  resources :rentals
  resources :users, only: [:new, :create, :show]

end

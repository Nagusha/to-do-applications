Rails.application.routes.draw do
   root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new"
  post "/users", to: "users#create"

  resources :to_dos, only: [ :index, :create, :destroy ] do
    member do
      patch :toggle
    end
  end
end

Rails.application.routes.draw do
  root "to_dos#index"
  
  resources :to_dos, only: [:index, :create, :destroy] do
    member do
      patch :toggle
    end
  end
end

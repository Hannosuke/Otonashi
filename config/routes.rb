Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, only: %i(index new create show destroy edit update)

  get "/login", to: "sessions#new"
end

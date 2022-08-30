Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, only: %i(index new create show destroy edit update) do
    resource :completions, only: %i(create destroy)
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :auth do
    get "auth/:provider/callback", to: "google#create"
  end
end

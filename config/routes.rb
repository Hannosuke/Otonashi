Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks, only: %i(index new create show destroy edit update) do
    resources :completions, only: %i(create)
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end

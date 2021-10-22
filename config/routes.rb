Rails.application.routes.draw do
  post "/sessions" => "sessions#create"

  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#delete"

  get "/favorites" => "favorites#index"
  post "/favorites" => "favorites#create"
end

Rails.application.routes.draw do
  post "/sessions" => "sessions#create"

  post "/users" => "users#create"
  get "/users/me" => "users#show"
  patch "/users/me" => "users#update"
  delete "/users/me" => "users#delete"

  get "/favorites" => "favorites#index"
  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#delete"

  get "/breeds" => "breeds#index"

  get "/api_dogs" => "api_dogs#index"
  get "/api_dogs/:api_dog_id" => "api_dogs#show"
end

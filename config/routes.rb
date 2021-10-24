Rails.application.routes.draw do
  post "/sessions" => "sessions#create"

  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#delete"

  get "/favorites" => "favorites#index"
  post "/favorites" => "favorites#create"
  delete "/favorites/:id" => "favorites#delete"

  get "/breeds" => "breeds#index"

  get "/api_dog" => "api_dog#index"
end

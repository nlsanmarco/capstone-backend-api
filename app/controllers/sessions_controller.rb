class SessionsController < ApplicationController
  require "http"
  system "clear"

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      response = HTTP.post("https://api.petfinder.com/v2/oauth2/token",
                           :json => {
                             :grant_type => "client_credentials",
                             :client_id => [API_KEY],
                             :client_secret => [API_SECRET],
                           })

      jwt = response.parse(:json)["access_token"]

      response2 = HTTP.auth("Bearer #{jwt}").get("https://api.petfinder.com/v2/animals?type=Dog&location=37410")

      dog_data = response2.parse(:json)
      render json: {}, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end
end

class SessionsController < ApplicationController
  require "http"
  system "clear"

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      response = HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => "#{Rails.application.credentials.petfinder[:api_key]}", :client_secret => "#{Rails.application.credentials.petfinder[:api_secret]}" })

      jwt = response.parse(:json)["access_token"]

      # response2 = HTTP.auth("Bearer #{jwt}").get("https://api.petfinder.com/v2/animals?type=Dog&location=37410")

      # dog_data = response2.parse(:json)
      render json: { "jwt": jwt.as_json }, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end
end

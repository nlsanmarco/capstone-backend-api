class ApplicationController < ActionController::API
  def get_token
    # if updated, also change in favorite model
    # retrieve token from cache
    # if token from cache is expired, generate new one
    Rails.cache.fetch("petfinder_access_token", expires_in: 1.hour) do
      HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => Rails.application.credentials.petfinder[:api_key], :client_secret => Rails.application.credentials.petfinder[:api_secret] }).parse(:json)["access_token"]
    end
  end
end

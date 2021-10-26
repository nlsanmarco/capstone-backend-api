class BreedsController < ApplicationController
  def index
    breeds = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/types/dog/breeds").parse(:json)["breeds"].map { |breed| breed["name"] }

    render json: breeds
  end
end

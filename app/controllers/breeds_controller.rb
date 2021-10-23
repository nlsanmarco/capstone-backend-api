class BreedsController < ApplicationController
  def index
    breeds = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/types/dog/breeds").parse(:json)["breeds"]

    render json: breeds
  end
end

class ApiDogsController < ApplicationController
  before_action :authenticate_user

  def index
    api_dogs = HTTP.auth("Bearer #{get_token}").get("#{query}").parse(:json)["animals"]

    render json: api_dogs
  end

  def show
    api_dog = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{params[:api_dog_id]}").parse(:json)["animal"]

    render json: api_dog
  end
end

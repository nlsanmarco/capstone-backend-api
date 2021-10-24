class ApiDogController < ApplicationController
  before_action :authenticate_user

  def index
    api_dogs = HTTP.auth("Bearer #{get_token}").get("#{query}").parse(:json)

    render json: api_dogs
  end
end

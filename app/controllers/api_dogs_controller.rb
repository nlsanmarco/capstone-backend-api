class ApiDogsController < ApplicationController
  before_action :authenticate_user

  def index
    api_dogs = HTTP.auth("Bearer #{get_token}").get("#{query}").parse(:json)

    render json: query
  end
end

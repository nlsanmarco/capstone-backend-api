class ApiDogsController < ApplicationController
  before_action :authenticate_user

  def index
    api_dogs = HTTP.auth("Bearer #{get_token}").get("#{current_user.specifications}").parse(:json)["animals"]

    render json: api_dogs
  end

  def show
    api_dog = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{params[:api_dog_id]}").parse(:json)["animal"]

    index = 0
    while index < current_user.dog_id_list.length
      if api_dog["id"].to_s == current_user.dog_id_list[index]
        favorite_dog = true
        break
      else
        index += 1
        favorite_dog = false
      end
    end

    api_dog["favorite_dog"] = favorite_dog

    render json: api_dog
  end
end

class ApiDogsController < ApplicationController
  before_action :authenticate_user

  def index
    api_dogs = HTTP.auth("Bearer #{get_token}").get("#{query}").parse(:json)
    dog_data = []
    # index = 0
    # while index < api_dogs.length
    name = api_dogs[0]["animals"][0]["name"]
    dog_data << name
    # index += 1
    # end
    # breed = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["breeds"]["primary"]
    # age = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["age"]
    # city = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["contact"]["address"]["city"]
    # state = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["contact"]["address"]["state"]
    # location = "#{city}, #{state}"
    # image_url = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["primary_photo_cropped"]["small"]
    # status = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["status"]

    # return { name: name , breed: breed, age: age, location: location, image_url: image_url, status: status }

    render json: api_dogs
  end
end

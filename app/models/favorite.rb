class Favorite < ApplicationRecord
  belongs_to :user

  def api_dog
    name = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["name"]
    breed = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["breeds"]["primary"]
    age = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["age"]
    city = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["contact"]["address"]["city"]
    state = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["contact"]["address"]["state"]
    location = "#{city}, #{state}"
    image_url = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["primary_photo_cropped"]["small"]
    status = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]["status"]
    return { name: name, breed: breed, age: age, location: location, image_url: image_url, status: status }
    # HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)["animal"]
  end

  def get_token
    # if updated, also change in application controller
    Rails.cache.fetch("petfinder_access_token", expires_in: 1.hour) do
      HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => Rails.application.credentials.petfinder[:api_key], :client_secret => Rails.application.credentials.petfinder[:api_secret] }).parse(:json)["access_token"]
    end
  end
end

class Favorite < ApplicationRecord
  belongs_to :user

  def api_dog
    response = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{api_dog_id}").parse(:json)

    if response["animal"]
      return response["animal"]
      # return {
      #          name: response["animal"]["name"],
      #          breed: response["animal"]["breeds"]["primary"],
      #          age: response["animal"]["age"],
      #          location: "#{response["animal"]["contact"]["address"]["city"]}, #{response["animal"]["contact"]["address"]["state"]}",
      #          image_url: response["animal"]["primary_photo_cropped"]["small"],
      #          status: response["animal"]["status"],
      #        }
    end
    Favorite.find(id).destroy
    return nil
  end

  def get_token
    # if updated, also change in application controller
    Rails.cache.fetch("petfinder_access_token", expires_in: 1.hour) do
      HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => Rails.application.credentials.petfinder[:api_key], :client_secret => Rails.application.credentials.petfinder[:api_secret] }).parse(:json)["access_token"]
    end
  end
end

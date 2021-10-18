require "http"
system "clear"

response = HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => "#{Rails.application.credetials.petfinder[:api_key]}", :client_secret => "#{Rails.application.credentials.petfinder[:api_secret]}" })

token = response.parse(:json)

puts jwt = token["access_token"]

# response2 = HTTP.auth("Bearer #{jwt}").get("https://api.petfinder.com/v2/animals?type=Dog&location=37410")

# dog_data = response2.parse(:json)

# puts dog_data

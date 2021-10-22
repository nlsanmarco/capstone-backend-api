require "http"
system "clear"

# response2 = HTTP.auth("Bearer #{response}").get("https://api.petfinder.com/v2/animals?type=Dog&location=37410")

# dog_data = response2.parse(:json)

# puts dog_data

response = HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => "#{Rails.application.credentials.petfinder[:api_key]}", :client_secret => "#{Rails.application.credentials.petfinder[:api_secret]}" })

access_token = response.parse(:json)["access_token"]

p

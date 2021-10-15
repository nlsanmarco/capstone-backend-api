require "http"

system "clear"

response = HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => "lVKjpJ3srpBPZyhJ9c63P40mKmgSVqJIQFE2C9Yl6g8RlZh01b", :client_secret => "XAy1x1tbyiOmhEFLCuhk8TroSvCAjb6HKHKTi5Xl" })

token = response.parse(:json)

jwt = token["access_token"]

response2 = HTTP.auth("Bearer #{jwt}").get("https://api.petfinder.com/v2/animals?type=Dog&location=37410")

dog_data = response2.parse(:json)

puts dog_data

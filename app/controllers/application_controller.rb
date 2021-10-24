class ApplicationController < ActionController::API
  def get_token
    # if updated, also change in favorite model
    # retrieve token from cache
    # if token from cache is expired, generate new one
    Rails.cache.fetch("petfinder_access_token", expires_in: 1.hour) do
      HTTP.post("https://api.petfinder.com/v2/oauth2/token", :json => { :grant_type => "client_credentials", :client_id => Rails.application.credentials.petfinder[:api_key], :client_secret => Rails.application.credentials.petfinder[:api_secret] }).parse(:json)["access_token"]
    end
  end

  def current_user
    auth_headers = request.headers["Authorization"]
    if auth_headers.present? && auth_headers[/(?<=\A(Bearer ))\S+\z/]
      token = auth_headers[/(?<=\A(Bearer ))\S+\z/]
      begin
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          { algorithm: "HS256" }
        )
        User.find_by(id: decoded_token[0]["user_id"])
      rescue JWT::ExpiredSignature
        nil
      end
    end
  end

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end

  def query
    if current_user.has_dogs == true
      good_with_dogs = "&good_with_dogs=true"
    else
      good_with_dogs = ""
    end

    if current_user.has_cats == true
      good_with_cats = "&good_with_cats=true"
    else
      good_with_cats = ""
    end

    if current_user.has_children == true
      good_with_children = "&good_with_children=true"
    else
      good_with_children = ""
    end

    query = "https://api.petfinder.com/v2/animals?type=Dog" + good_with_dogs + good_with_cats + good_with_children + "&location=#{current_user.location}"

    return query
  end
end

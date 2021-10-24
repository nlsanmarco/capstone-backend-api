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

    if current_user.lives_in_house == false && current_user.preferred_size == null
      size = "&size=small, medium"
    elsif current_user.preferred_size == "small"
      size = "&size=small"
    elsif current_user.preferred_size == "medium"
      size = "&size=medium"
    elsif current_user.preferred_size == "large"
      size = "&size=large"
    elsif current_user.preferred_size == "x-large"
      size = "&size=xlarge"
    else
      size = ""
    end

    if current_user.has_yard == false || current_user.hours_away > 8 && current_user.preferred_age == null
      age = "&age=adult,senior"
    elsif current_user.preferred_age == "baby"
      age = "&age=baby"
    elsif current_user.preferred_age == "young"
      age = "&age=young"
    elsif current_user.preferred_age == "adult"
      age = "&age=adult"
    elsif current_user.preferred_age == "senior"
      age = "&age=senior"
    else
      age = ""
    end

    if current_user.lives_in_house == false || current_user.hours_away_per_day > 8 && current_user.dog_training_experience == false
      house_trained = "&house_trained=true"
    else
      house_trained = ""
    end

    if current_user.preferred_gender == "female"
      gender = "&gender=female"
    elsif current_user.preferred_gender == "male"
      gender = "&gender=male"
    else
      gender = ""
    end

    query = "https://api.petfinder.com/v2/animals?type=Dog" + good_with_dogs + good_with_cats + good_with_children + size + age + house_trained + gender + "&location=#{current_user.location}"

    return query
  end
end

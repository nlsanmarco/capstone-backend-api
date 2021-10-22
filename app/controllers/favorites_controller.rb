class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    favorites = current_user.favorites
    # dog_ids = []
    # favorites.each do |favorite|
    #   dog_ids << favorite.api_dog_id
    # end
    # # favorite_list = []
    # # dog_ids.each do |dog_id|
    # favorite_data = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/animals/#{dog_ids.first}")
    # # breed = favorite_data.body
    # # favorite_list << breed
    # # favorite_list << favorite_data.body
    # # end

    render json: favorites
  end

  def create
    favorite = Favorite.new(
      user_id: current_user.id,
      api_dog_id: params[:api_dog_id],
    )
    if favorite.save
      render json: favorite.as_json
    else
      render json: favorite.errors.full_messages,
             status: :unprocessable_entity
    end
  end

  def delete
    favorite = Favorite.find_by(id: params[:id])
    favorite.destroy
    render json: { message: "Favorite successfully deleted." }
  end
end

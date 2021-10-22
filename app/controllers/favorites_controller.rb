class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    favorites = current_user.favorites

    render json: favorites.as_json
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

class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    favorites = current_user.favorites

    render json: favorites.as_json
  end
end

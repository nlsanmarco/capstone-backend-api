class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: jwt, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end
end

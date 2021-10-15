class SessionsController < ApplicationController
end

def create
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
  end
end

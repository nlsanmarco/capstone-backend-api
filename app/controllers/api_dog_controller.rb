class ApiDogController < ApplicationController
  before_action :authenticate_user
end

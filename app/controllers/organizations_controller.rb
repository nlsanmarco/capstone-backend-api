class OrganizationsController < ApplicationController
  before_action :authenticate_user

  def show
    organization = HTTP.auth("Bearer #{get_token}").get("https://api.petfinder.com/v2/organizations/#{params[:org_id]}").parse(:json)["organization"]

    render json: organization
  end
end

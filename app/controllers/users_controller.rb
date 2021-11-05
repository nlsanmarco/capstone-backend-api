class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]

  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
    )
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    user = current_user
    render json: user
  end

  def update
    user = current_user
    user.name = params[:name] || user.name
    user.email = params[:email] || user.email
    # user.password
    user.has_dogs = params[:has_dogs] || user.has_dogs
    user.has_cats = params[:has_cats] || user.has_cats
    user.has_children = params[:has_children] || user.has_children
    user.lives_in_house = params[:lives_in_house] || user.lives_in_house
    user.has_yard = params[:has_yard] || user.has_yard
    user.dog_training_experience = params[:dog_training_experience] || user.dog_training_experience
    user.hours_away_per_day = params[:hours_away_per_day] || user.hours_away_per_day
    user.preferred_breed = params[:preferred_breed] || user.preferred_breed
    user.preferred_age = params[:preferred_age] || user.preferred_age
    user.preferred_gender = params[:preferred_gender] || user.preferred_gender
    user.preferred_size = params[:preferred_size] || user.preferred_size
    user.special_needs = params[:special_needs] || user.special_needs
    # user.location = params[:location] || user.location
    user.save
    if user.save
      render json: user
    else
      render json: user.errors.full_messages,
             status: :uprocessable_entity
    end
  end

  def delete
    user = current_user
    user.destroy
    render json: { message: "User successfully deleted." }
  end
end

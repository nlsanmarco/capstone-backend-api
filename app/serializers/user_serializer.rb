class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :has_dogs, :has_cats, :has_children, :lives_in_house, :has_yard, :dog_training_experience, :hours_away_per_day, :preferred_breed, :preferred_age, :preferred_gender, :preferred_size, :sepcial_needs, :location
end

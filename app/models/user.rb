class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :favorites, dependent: :destroy

  def specifications
    if has_dogs == true
      good_with_dogs = "&good_with_dogs=true"
    else
      good_with_dogs = ""
    end

    if has_cats == true
      good_with_cats = "&good_with_cats=true"
    else
      good_with_cats = ""
    end

    if has_children == true
      good_with_children = "&good_with_children=true"
    else
      good_with_children = ""
    end

    if lives_in_house == false && preferred_size == ""
      size = "&size=small,medium"
    elsif preferred_size != ""
      size = "&size=#{preferred_size}"
    else
      size = ""
    end

    if has_yard == false && preferred_age == "" || hours_away_per_day > 8 && preferred_age == ""
      age = "&age=adult,senior"
    elsif preferred_age != ""
      age = "&age=#{preferred_age}"
    else
      age = ""
    end

    if lives_in_house == false && dog_training_experience == false || hours_away_per_day > 8 && dog_training_experience == false
      house_trained = "&house_trained=true"
    else
      house_trained = ""
    end

    if preferred_gender == "female"
      gender = "&gender=female"
    elsif preferred_gender == "male"
      gender = "&gender=male"
    else
      gender = ""
    end

    if preferred_breed == ""
      breed = ""
    else
      breed = "&breed=#{preferred_breed}"
    end

    if special_needs == true
      special_needs = "&special_needs=true"
    else
      special_needs = ""
    end

    query = "https://api.petfinder.com/v2/animals?type=Dog" + good_with_dogs + good_with_cats + good_with_children + size + age + house_trained + gender + breed + special_needs + "&location=37410"

    return query
  end

  def dog_id_list
    favorites_list = []
    index = 0
    while index < favorites.length
      favorites_list << favorites[index]["api_dog_id"]
      index += 1
    end

    return favorites_list
  end
end

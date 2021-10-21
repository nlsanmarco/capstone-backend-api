class RemoveDogApiIdFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :dog_api_id, :integer
    add_column :favorites, :api_dog_id, :string
  end
end

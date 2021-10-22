class RemoveLivesInApartmentFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :lives_in_apartment, :boolean
  end
end

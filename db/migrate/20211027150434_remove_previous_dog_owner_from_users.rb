class RemovePreviousDogOwnerFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :previous_dog_owner, :string
  end
end

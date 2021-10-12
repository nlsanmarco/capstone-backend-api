class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :has_dogs
      t.boolean :has_cats
      t.boolean :has_children
      t.boolean :lives_in_house
      t.boolean :lives_in_apartment
      t.boolean :has_yard
      t.boolean :previous_dog_owner
      t.boolean :dog_training_experience
      t.integer :hours_away_per_day
      t.string :preferred_breed
      t.string :preferred_age
      t.string :preferred_gender
      t.string :preferred_size
      t.boolean :special_needs

      t.timestamps
    end
  end
end

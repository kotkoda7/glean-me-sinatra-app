

class CreateLocations < ActiveRecord::Migration
  def change
  	create_table :locations do |t|
      t.integer :user_id
      t.integer :edible_id
  		t.string :loc_type
  		t.float :lat
  		t.float :lng
  		t.text :address
  		t.text :description
  	end
  end
end
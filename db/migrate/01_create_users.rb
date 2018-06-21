class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :username
  		t.string :password_digest
  		t.integer :location_id
  	end
  end
end


class CreateEdibles < ActiveRecord::Migration
  def change
  	create_table :edibles do |t|
  		t.string :name
  	end
  end
end
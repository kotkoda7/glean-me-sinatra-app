class Edible < ActiveRecord::Base
	has_many :locations
	has_many :users

	def self.valid_params?(params)
    	return !params[:name].empty?
  	end
  	
end
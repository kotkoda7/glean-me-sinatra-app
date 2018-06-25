class Location < ActiveRecord::Base

	belongs_to :user
	has_many :edibles

	def self.valid_params?(params)
    	return !params[:address].empty? || (!params[:lat].empty? && !params[:lng].empty?) && !params[:description].empty? && !params[:edible_id].empty?
  	end
 
	
end

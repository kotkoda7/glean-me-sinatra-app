class Location < ActiveRecord::Base
 
  belongs_to :user

	def self.valid_params?(params)
	  return params[:address].nil? || params[:lat].nil?
	end

end

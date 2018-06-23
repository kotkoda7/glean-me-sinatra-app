class LocationsController < ApplicationController

	get "/locations" do 
		authenticate_user
		@locations = Location.all
		erb :'locations/index'
	end
end
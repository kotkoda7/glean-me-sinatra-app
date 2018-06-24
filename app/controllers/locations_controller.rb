class LocationsController < ApplicationController

	get "/locations" do 
		authenticate_user
		@locations = Location.all
		erb :'locations/index'
	end

	get '/locations/new' do
		authenticate_user
		@locations = Location.all
		@edibles = Edible.all
		erb :'/locations/new'
	end

	get "/locations/:id/edit" do
    	authenticate_user
   		@location = Location.find(params[:id])
    	erb :'locations/edit'
    end

	get '/locations/:id' do
		authenticate_user
		@location = Location.find_by_id(params[:id])
		if @location
			erb :'/locations/show'
		else
			redirect '/locations'
		end
	end

end
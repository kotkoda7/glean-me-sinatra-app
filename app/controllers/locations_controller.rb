class LocationsController < ApplicationController

  get "/locations" do
    authenticate_user
    @locations = Location.all
    erb :'locations/index'
  end

  get "/locations/new" do
    authenticate_user
    @locations = Location.all
    @edibles = Edible.all
    @error_message = params[:error]
    erb :'locations/new'
  end

  get "/locations/:id/edit" do
    authenticate_user
    @location = Location.find(params[:id])
    @edibles = Edible.all
    erb :'locations/edit'
  end

   post "/locations/:id" do
    authenticate_user
    @location = Location.find(params[:id])
    unless Location.valid_params?(params)
      redirect "/locations/#{@location.id}/edit?error=invalid location"
    end
    @location.update(params.select{|k| k=="address" || k=="lat"})
    redirect "/locations/#{@location.id}"
  end

  get "/locations/:id" do
    authenticate_user
    @location = Location.find(params[:id])
    erb :'locaitons/show'
  end

  post "/locations" do
  	authenticate_user

  	unless Location.valid_params?(params)
    		redirect "/locations/new?error=invalid location"
  	end

  	Location.create(params)
  	redirect "/locations"
  end

end
class LocationsController < ApplicationController

  get "/locations" do
    authenticate_user
    @locations = Location.all
    erb :'locations/index'
  end

  post "/locations" do
    authenticate_user

    unless Location.valid_params?(params)
        redirect "/locations/new?error=invalid location"
    end

    Location.create(params[:location])
    redirect "/locations"
  end

  get "/locations/new" do
    authenticate_user
    @locations = Location.all
    @edibles = Edible.all
    erb :'locations/new'
  end

  get "/locations/:id/edit" do
    authenticate_user
    @location = Location.find(params[:id])
    @locations = Location.all
    @edible = Edible.find(params[:id])
    @edibles = Edible.all
    erb :'locations/edit'
  end

   post "/locations/:id" do
    authenticate_user
    @location = Location.find(params[:id])
    unless Location.valid_params?(params)
      redirect "/locations/#{@location.id}/edit?error=invalid location"
    end
    @location.update(params.select{|k| k=="address" || k=="lat" || k=="lng" || k=="description" || k=="edible_id"})
    redirect "/locations/#{@location.id}"
  end

  get "/locations/:id" do
    authenticate_user
    @edible = Edible.find(params[:id])
    @location = Location.find(params[:id])
    erb :'locations/show'
  end

  

end
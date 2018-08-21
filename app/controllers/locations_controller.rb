class LocationsController < ApplicationController

  
  get '/locations' do
    authenticate_user
    @locations = Location.all
    erb :'/locations/index'
  end

  get '/locations/new' do
    authenticate_user
    @locations = Location.all
    erb :'/locations/new'
  end

  post '/locations/new' do
    authenticate_user

    if Location.valid_params?(params)
      params[:location][:edible] << params[:location][:selected_edible]
      #@location = Location.create(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible: params[:location][:edible], user_id: current_user.id)
      Location.find_or_create_by(params)

      flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "Both fields must be filled in. Please complete the form."
      redirect '/locations/new'
    end
    
  end

get '/locations/:id' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    if @location
      erb :'/locations/show'
    else
      flash[:message] = "This location does not exist"
      redirect '/locations'
    end
  end

  get '/locations/:id/edit' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
     @locations = Location.all
    if @location && @location.user == current_user
      erb :'/locations/edit'
    else @location && !@location.user == current_user
      flash[:message] = "You cannot change another user's location."
      redirect to "/locations/#{@location.id}"
    #else
      #flash[:message] = "This location doesn't exist."
      #redirect to "/locations"
      #erb :'/locations/edit'
    end
  end

  patch "/locations/:id/edit" do
    authenticate_user
    @location = Location.find_by(params[:id])
    @locations = Location.all
    #if Location.valid_params?(params)
    @location.update(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible: params[:location][:edible])

      #flash[:message] = "Both fields must be filled in. Please complete the form."
      redirect to "/locations/#{@location.id}"
    #end
    
  end


  get '/locations/:id/delete' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    if @location.user == current_user
      @location.destroy

      flash[:message] = "The location is successfully deleted."
      redirect "/locations"
    else
      flash[:message] = "You cannot delete another user's location."
      redirect to "/locations/#{@location.id}"
    end
  end
end
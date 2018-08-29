class LocationsController < ApplicationController

  get '/locations' do
    authenticate_user
    @locations = Location.all
    erb :'/locations/index'
  end

  get '/locations/new' do
    authenticate_user
    
    @locations = Location.all.group(:loc_type)
    @edibles = Location.all.group(:edible)

    erb :'/locations/new'
  end

  post '/locations/new' do
    authenticate_user
    params[:location][:edible] = params[:location][:selected_edible] if !params[:location][:selected_edible].empty?

    if (!params[:location][:address].empty? && !params[:location][:lat].empty? && !params[:location][:lng].empty?) && (!params[:location][:edible].empty? || !params[:location][:selected_edible].empty?)
     
      @location = Location.create(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible: params[:location][:edible],user_id: current_user.id)
      flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "Location and 'food type' fields must be filled in. Please complete the form."
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
    @locations = Location.all.group(:loc_type)
    @edibles = Location.all.group(:edible)

     if @location.user == current_user
      erb :'/locations/edit'
    else 
      flash[:message] = "You cannot change another user's location."
      redirect to "/locations/#{@location.id}"
    end
  end


  patch '/locations/:id/edit' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    if (!params[:location][:address].empty? && !params[:location][:lat].empty? && !params[:location][:lng].empty?) && !params[:location][:edible].empty?

        @location.update(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible: params[:location][:edible], user_id: current_user.id)

      flash[:message] = "The location is successfully updated."
      redirect to "/locations/#{@location.id}"
    else
      flash[:message] = "Location and 'food type fields' must be filled in. Please complete the form."
      redirect to "/locations/#{@location.id}/edit"
    end
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



class LocationsController < ApplicationController

  get '/locations' do
    authenticate_user
    @locations = Location.all
    erb :'/locations/index'
  end

  get '/locations/new' do
    authenticate_user
    @edibles = Edible.all
    @locations = Location.all
    erb :'/locations/new'
  end

  post '/locations/new' do
    authenticate_user
    params[:location][:edible] = params[:location][:selected_edible] if !params[:location][:selected_edible].empty?

    if !params[:location][:address].empty? && !params[:location][:edible].empty?
      edible = Edible.find_or_create_by(name: params[:location][:edible])
      @location = Location.create(address: params[:location][:address], 
        lat: params[:location][:lat], lng: params[:location][:lng], 
        description: params[:location][:description], 
        loc_type: params[:location][:loc_type], edible: edible, user_id: current_user.id)

      flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
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
    @edibles = Edible.all
    if @location && @location.user == current_user
      erb :'/locations/edit'
    elsif @location && !@location.user == current_user
      flash[:message] = "You cannot change another user's location."
      redirect to "/locations/#{@location.id}"
    else
      flash[:message] = "This location doesn't exist."
      redirect to "/locations"
    end
  end



  patch '/locations/:id/edit' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    if !params[:location][:edible].empty? && !params[:location][:name].empty?
      if edible ||= Edible.find_by(name: params[:location][:edible])
        @location.update(name: params[:location][:name], edible: edible)
      else edible = Edible.create(name: params[:location][:edible], user_id: current_user.id)
        @location.update(address: params[:location][:address], edible: edible)
      end
      flash[:message] = "The location is successfully updated."
      redirect to "/locations/#{@location.id}"
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
      redirect to "/locations/#{@location.id}/edit"
    end
  end

  get '/locations/:id/delete' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    @edible = @location.edible
    if @location.user == current_user
      @location.destroy

      flash[:message] = "The location is successfully deleted."
      redirect "/edibles/#{@edible.id}"
    else
      flash[:message] = "You cannot delete another user's location."
      redirect to "/locations/#{@location.id}"
    end
  end

   get '/locations/:id/add_edible' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    erb :'/locations/add_edible'
  end

  post '/locations/:id/add_edible' do
    @location = Location.find_by_id(params[:id])
    if !params[:location_address].empty?
      Edible.create(address: params[:location_address], location: @location, user: current_user)

      flash[:message] = "Food type is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "Enter the food type."
      redirect "/locations/#{@location.id}/add_edible"
    end
  end
end

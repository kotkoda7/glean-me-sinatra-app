class LocationsController < ApplicationController

  get '/locations' do
    authenticate_user
    @locations = Location.all.sort_by &:id
    erb :'/locations/index'
  end

  get '/locations/new' do
    authenticate_user
    @locations = Location.all
    @edibles = Edible.all
    erb :'/locations/new'
  end

  post '/locations/new' do
    authenticate_user

    if !params[:location][:edible].nil? && (params[:location][:address].nil? || (!params[:location][:lat].nil? && !params[:location][:lng].nil?))
      params[:location][:edible] = params[:location][:selected_edible1] && params[:location][:edible] = params[:location][:selected_edible2]
      
      @edible = Edible.find_or_create_by(name: params[:location][:edible])
      @location = Location.create(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible_id: params[:location][:edible], user_id: current_user.id)
      flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
      redirect '/locations/new'
    end
  end
  

  get '/locations/:id' do
    authenticate_user
    @location = Location.find(params[:id])
    @edibles = Edible.all
    if @location
      erb :'/locations/show'
    else
      flash[:message] = "This location does not exist"
      redirect '/locations'
    end
  end

  get '/locations/:id/edit' do
    authenticate_user
    @location = Location.find(params[:id]) 
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
    @location = Location.find(params[:id])

    if !params[:location][:edible].nil? && !params[:location][:name].nil?
      if edible ||= Edible.find_by(name: params[:location][:edible])
        @location.update(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible: edible, user_id: current_user.id)
      else edible = Edible.create(name: params[:location][:edible], user_id: current_user.id)
        @location.update(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], loc_type: params[:location][:loc_type], edible_id: params[:location][:edible], user_id: current_user.id)
      end
      flash[:message] = "The location is successfully updated."
      redirect to("/locations/#{@params[:id]}")
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
      redirect to "/locations/#{@location.id}/edit"
    end
  end

  get '/locations/:id/delete' do
    authenticate_user
    @location = Location.find(params[:id])
    @edible = @location.edible_id
    if @location.user == current_user
      @location.destroy

      flash[:message] = "The location is successfully deleted."
      redirect '/locations'
    else
      flash[:message] = "You cannot delete another user's location."
      redirect to "/locations/#{@location.id}"
    end
  end
end

class LocationsController < ApplicationController


  get "/locations" do
    authenticate_user
    @locations = Location.all
    erb :'locations/index'
  end

=begin
  post "/locations" do
    authenticate_user

    unless Location.valid_params?(params)
        redirect "/locations/new?error=invalid location"
    end

    Location.create(params[:location])
    redirect "/locations"
  end
=end

get "/locations/new" do
    authenticate_user
    @locations = Location.all
    @edibles = Edible.all
    erb :'locations/new'
  end

post '/locations/new' do
    authenticate_user
  if !params[:location][:selected_edible1].empty? 
    params[:location][:edible] = params[:location][:selected_edible1] ||
  if !params[:location][:selected_edible2].empty?
    params[:location][:edible] = params[:location][:selected_edible2] 

    if !params[:location][:address].empty? || (!params[:location][:lat].empty? && !params[:location][:lat].empty?) && !params[:location][:edible].empty?
      @edible = Edible.find_or_create_by(name: params[:location][:edible])
      @location = Location.create(address: params[:location][:address], lat: params[:location][:lat], lng: params[:location][:lng], description: params[:location][:description], edible: edible, user_id: current_user.id)

      flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
      redirect '/locations/new'
  end
end
end


=begin
get "/locations/:id" do
    authenticate_user

    @location = Location.find(params[:id])
    erb :'locations/show'
  end
=end

get '/locations/:id' do
    authenticate_user
    @edible = Edible.find(params[:id])
    @location = Location.find(params[:id])
    if @location
      erb :'/locations/show'
    else
      flash[:message] = "This location does not exist"
      redirect '/locations'
    end
  end

=begin
  
  post "/locations/:id" do
    authenticate_user
    @location = Location.find(params[:id])
    unless Location.valid_params?(params)
      redirect "/locations/#{@location.id}/edit?error=invalid location"
    end
    @location.update(params.select{|k| k=="address" || k=="lat" || k=="lng" || k=="description" || k=="edible_id"})
    redirect "/locations/#{@location.id}"
  end
=end

  get "/locations/:id/edit" do
    authenticate_user
    @location = Location.find_by_id(params[:id])
      if @location && @location.user == current_user
        erb :'locations/edit'
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
        @location.update(address: params[:location][:address], 
        lat: params[:location][:lat], 
        lng: params[:location][:lng],
        loc_type: params[:location][:loc_type],
        description: params[:location][:description],
        edible: edible,
        user_id: current_user.id)
      else edible = Edible.create(name: params[:location][:edible], user_id: current_user.id)
        @location.update(address: params[:location][:address], 
        lat: params[:location][:lat], 
        lng: params[:location][:lng],
        loc_type: params[:location][:loc_type],
        description: params[:location][:description], edible: edible)
      end
      flash[:message] = "The location is successfully updated."
      redirect to "/locations/#{@location.id}"
    else
      flash[:message] = "All fields must be filled in. Please complete the form."
      redirect to "/locations/#{@location.id}/edit"
    end
  end
end

get '/locations/:id/delete' do
    authenticate_user
    @location = Location.find(params[:id])
    @edible = @location.edible_id
    if @location.user == current_user
      @location.delete

      flash[:message] = "The location is successfully deleted."
      redirect "/locations"
    else
      flash[:message] = "You cannot delete another user's location."
      redirect to "/locations"
    end
  end
end


=begin
  get '/locations/:id/add_edible' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    @edibles = Edible.all
    erb :'/locations/add_edible'
  end
=end

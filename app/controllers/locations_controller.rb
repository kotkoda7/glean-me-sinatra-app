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
    params[:location][:edible] = params[:edible][:name1] if !params[:edible][:name1].empty?
    params[:location][:edible] = params[:edible][:name2] if !params[:edible][:name2].empty? 
    if !params[:location][:address].empty? && !params[:location][:edible].empty?
      edible = Edible.find_or_create_by(name: params[:location][:edible])
      @location = Location.create(address: params[:location][:address], 
        lat: params[:location][:lat], 
        lng: params[:location][:lng],
        #loc_type: params[:location][:loc_type],
        description: params[:location][:description],
        user_id: current_user.id)

      #flash[:message] = "The location is successfully added."
      redirect "/locations/#{@location.id}"
    else
      #flash[:message] = "Both fields must be filled in. Please complete the form."
      redirect '/locations/new'
  end
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

    get "/locations/:id/edit" do
    authenticate_user
    @location = Location.find(params[:id])
    @locations = Location.all
    @edible = Edible.find(params[:id])
    @edibles = Edible.all
    erb :'locations/edit'
  end

  get "/locations/:id" do
    authenticate_user
    @edible = Edible.find(params[:id])
    @edibles = Edible.all
    @location = Location.find(params[:id])
    erb :'locations/show'
  end

  get '/locations/:id/add_edible' do
    authenticate_user
    @location = Location.find_by_id(params[:id])
    @edibles = Edible.all
    erb :'/locations/add_edible'
  end

  post '/locations/:id/add_edible' do
    @location = Location.find_by_id(params[:id])
    if !params[:edible_name].empty?
      Edible.create(name: params[:edible_name1], name: params[:edible_name2], address: params[:location][:address], 
        lat: params[:location][:lat], 
        lng: params[:location][:lng],
        #loc_type: params[:location][:loc_type],
        description: params[:location][:description],
        user_id: current_user.id)

      redirect to "/locations/#{@location.id}"
    else
      redirect to "/locations/#{@location.id}/add_edible"
    end
  end

get '/locations/:id/delete' do
    authenticate_user
    @location = Location.find(params[:id])
    @edible = @location.edible_id
   if @location.user == current_user
      @location.delete

      #flash[:message] = "The location is successfully deleted."
      redirect "/locations"
    else
      #flash[:message] = "You cannot delete another user's location."
      redirect to "/locations"
    end
  end

end
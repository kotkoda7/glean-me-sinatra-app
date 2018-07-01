class EdiblesController < ApplicationController

get "/edibles" do
    authenticate_user
    @edibles = Edible.all
    erb :'edibles/index'
 end

 post "/edibles" do
  	authenticate_user

  	#unless Edible.valid_params?(params)
    	#redirect "/edibles/new?error=invalid food type"
  	#end

    @edible = Edible.create(params[:edible])
  	redirect "/edibles"
  end

=begin
 get "/edibles/new" do
    authenticate_user
    erb :'edibles/new'
 end

=end

get "/edibles/:id/edit" do
    authenticate_user
    @edible = Edible.find(params[:id])
    erb :'edibles/edit'
  end

 post "/edibles/:id" do
    authenticate_user 
    @edible = Edible.find(params[:id])
    unless Edible.valid_params?(params)
      redirect "/edibles/#{@edible.id}/edit"
    end
    @edible.update(params.select{|k|k=="name"})
    redirect "/edibles/#{@edible.id}"
  end

  get "/edibles/:id" do
    authenticate_user
    @edible = Edible.find(params[:id])
    erb :'edibles/show'
  end


  

  
end
class EdiblesController < ApplicationController

	get "/edibles" do
    authenticate_user
    @edibles = Edible.all
    erb :'edibles/index'
  end
  
end
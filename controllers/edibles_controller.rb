class EdiblesController < ApplicationController

  get '/edibles' do
    authenticate_user
    @edibles = Edible.all.sort_by &:name
    erb :'/edibles/index'
  end

  get '/edibles/:id' do
    authenticate_user
      @edible = Edible.find_by_id(params[:id])
      erb :'/edibles/show'
  end

 

end

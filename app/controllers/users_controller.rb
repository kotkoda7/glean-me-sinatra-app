class UsersController < ApplicationController 

  
  get '/users/:id' do
    if !logged_in?
      redirect '/locations'
    end

      @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'locations/show'
    else
      redirect '/locations'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect to '/locations'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = user.id
      redirect '/locations'
    end
  end

get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in."
      redirect '/locations'
    else
      erb :'users/login'
    end
end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/locations"
    else
      flash[:message] = "Invalid username or/and password. Please try again."
      redirect '/login'
    end
  end

get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end

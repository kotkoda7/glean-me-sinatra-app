class UsersController < ApplicationController 


get '/login' do
	if !logged_in?
		erb :'users/login'
	else
		redirect '/locations'
	end
end

post '/login' do
	user = User.find_by(:username =>params[:username])
	if user && user.authenticate(params[:password])
		session[:user_id] = user.user_id
		redirect '/locations'
	else
		redirect '/signup'
	end	
end

get '/signup' do
	if !logged_in?
 		erb :'users/signup'
 	else
		redirect '/locations'
	end
end


post '/signup' do
	if params[:username] == "" || params[:password] == ""
		redirect '/signup'
	else
		@user = User.create(:username => params[:username], :password => params[:password])
      	session[:user_id] = @user.id
      	redirect '/locations'
	end
end

get '/logout' do
    if session[:user_id] != nil
    	session.clear
    	redirect to '/login'
    else
    	redirect '/'
  	end
end

post '/logout' do
    session.clear
    redirect '/'
  end
end
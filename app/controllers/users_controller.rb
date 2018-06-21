class UsersController < ApplicationController 



get '/login' do
	if logged_in?
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
	if logged_in?
 		erb :'users/signup'
 	else
		redirect '/locations'
	end
end


post '/signup' do
	


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
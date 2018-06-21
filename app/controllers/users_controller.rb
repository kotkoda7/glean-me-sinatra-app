class UsersController < ApplicationController 

get '/signup' do
 erb :'users/signup'
end

get '/login' do
	erb :'users/login'
end

post '/login' do

end

post '/signup' do
end
end
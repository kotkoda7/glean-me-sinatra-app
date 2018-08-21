require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'foodforall'
    
  end


get '/' do
    if logged_in?
      @user = current_user
      erb :'/users/index'
    else
      erb :index
    end
  end


  
helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

  private

    def authenticate_user
      if !logged_in?
        flash[:message] = "You must be logged in to access this page"
        redirect '/login'
      end
    end

end
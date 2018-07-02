require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'foodforall'
  end

get "/" do
   if logged_in?
      @user = current_user
      erb :'/users/login'
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
        redirect "/login?error=You have to be logged in to do that"
      end
  end
  end
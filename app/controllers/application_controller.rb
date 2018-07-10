# require './config/environment'
# require 'sinatra/base'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "underground_secret"
  end

  get "/" do

    erb :index
  end

  helpers do
   def logged_in?
     !!session[:user_id]
   end

   def current_user
     User.find(session[:user_id])
   end
  end

  def owner?
    @event = Event.find_by_slug(params[:slug])
    @user = User.find_by_id(session[:user_id])
    if @event.user_id == @user.id
      true
    end
  end

end

require 'rack-flash'
class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/events'
    else
      flash[:message] = "Oh - oh! Something went wrong. Please ensure all fields are completed to sign up. OR if you are already a memeber - please sign in instead."
      redirect '/'
    end
  end

  get '/show' do
    @user = current_user
    erb :'users/show'
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/events'
    else
      flash[:message] = "Oh- oh something went wrong! Please check your username and password. OR if you aren't a memeber yet - please sign up first."

      redirect '/'
    end
  end

  get '/logout' do
    if !logged_in?
      redirect '/'
    else
      session.clear
      redirect '/login'
    end
  end

end

require 'rack-flash'
class UsersController < ApplicationController
  # enable :sessions
  # use Rack::Flash

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/events'
    else
      redirect '/signup'
    end
  end

  get '/show' do
    @user = User.find_by_id(session[:user_id])
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
      # create error message instructing username and password do not match. OR create new account
      redirect :'/'
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

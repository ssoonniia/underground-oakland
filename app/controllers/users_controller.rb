class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/'
      else
        redirect '/signup'
      end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @users = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/events'
    else
      erb :'users/login'
    end

  end




end

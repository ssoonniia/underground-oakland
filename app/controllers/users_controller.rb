class UsersController < ApplicationController

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





end

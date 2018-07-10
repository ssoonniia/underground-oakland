require 'rack-flash'

class EventsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/events' do
    if !logged_in?
      flash[:message] = "Please log or sign up to see events."
      redirect '/'
    else
      erb :'events/events'
    end
  end

  get '/events/new' do
    if !logged_in?
      flash[:message] = "Please log in or sign up to create a new event."
      redirect '/'
    else
      erb :'events/create_event'
    end
  end

  post '/events/new' do
    @event = Event.create(params['event'])
    @user = User.find_by_id(session[:user_id])
    @event.user = @user

    if @event.save
      redirect "events/#{@event.slug}"
    else
      flash[:message] = "Oh Oh ...seems like some fields were not completed. Please complete all fields!"
      redirect '/events/new'
    end
  end

  get '/events/:slug' do
    if !logged_in?
      flash[:message] = "Please log in or sign up to see events."
      redirect '/'
    elsif !owner?
      flash[:message] = "Yikes - you didn't create this event. You cannot edit this event"
      redirect '/events'
    else
      erb :'events/show_event'
    end
  end


  get '/events/:slug/edit' do
    if !logged_in?
      flash[:message] = "Please log in or sign up to create a new event."
      redirect '/'
    elsif !owner?
      flash[:message] = "Yikes - you didn't create this event. You cannot edit this event"
      redirect '/events'
    else
      erb :'events/edit_event'
    end
  end

  patch '/events/:slug' do
    @event = Event.find_by_slug(params[:slug])
    @event.update(params['event'])
    @event.save

    erb :'events/show_event'
  end

  get '/events/:slug/delete' do
    if !logged_in?
      redirect '/'
    elsif !owner?
      flash[:message] ="Yikes - you didn't create this event. You cannot delete this event"
      redirect '/events'
    else
      erb :'events/delete_event'
    end
  end

  delete '/events/:slug/delete' do
    @event = Event.find_by_slug(params[:slug])
    @user = User.find_by_id(session[:user_id])
    @event.delete
    redirect '/events'
  end

end

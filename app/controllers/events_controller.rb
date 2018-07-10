require 'rack-flash'
class EventsController < ApplicationController
  # enable :sessions
  # use Rack::Flash
# events
  get '/events' do
    if !logged_in?
      # flash[:message] = "Please log or sign up to see events."
      redirect '/'
    else
      erb :'events/events'
    end
  end

  get '/events/new' do
    if !logged_in?
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
      redirect '/events/new'
    end
  end

  get '/events/:slug' do
    if !logged_in?
      redirect '/'
    elsif !owner?
      #error not your event
      redirect '/events'
    else
      erb :'events/show_event'
    end
  end


  get '/events/:slug/edit' do
    if !logged_in?
      redirect '/'
    elsif !owner?
      # error you cannot edit this event
      redirect '/events'
    else
      erb :'events/edit_event'
    end
  end

  patch '/events/:slug/edit' do
    @event = Event.find_by_slug(params[:slug])
    @event.update(params['event'])
    @event.save

    erb :'events/show_event'
  end

  get '/events/:slug/delete' do
    if !logged_in?
      redirect '/'
    elsif !owner?
      redirect '/events'
    else
      erb :'events/delete_event'
    end
  end

  delete '/events/:slug/delete' do
    @event = Event.find_by_slug(params[:slug])
    @user = User.find_by_id(session[:user_id])

    if owner?
      @event.delete
      redirect '/events'
    else
      #message not allowed to delete
      redirect '/events'
    end
  end
  
end

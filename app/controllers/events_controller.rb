class EventsController < ApplicationController

  get '/events' do
    if !logged_in?
      redirect '/login'
    else
      erb :'events/events'
    end
  end

  get '/events/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'events/create_event'
    end
  end

  post '/events/new' do
    @event = Event.create(params['event'])
    @user = User.find_by_id(session[:user_id])
    @event.user = @user

    if @event.save
      redirect "/event/#{@event.slug}"
    else
      redirect '/events/new'
    end
  end

  get '/events/:slug' do
    @event = Event.find_by_slug(params[:slug])

    erb :'events/show_event'

end

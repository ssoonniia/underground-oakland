class EventsController < ApplicationController

# events
  get '/events' do
    if !logged_in?
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
    else
      @event = Event.find_by_slug(params[:slug])
      erb :'events/show_event'
    end
  end

  get '/events/:slug/edit' do
    if !logged_in?
      redirect '/'
    else
      @event = Event.find_by_slug(params[:slug])
      erb :'events/edit_event'
    end
  end

  patch '/events/:slug/edit' do
    @event = Event.find_by_slug(params[:slug])
    @event.update(params['event'])
    @event.save

    erb :'events/show_event'
  end

  get "/events/:slug/delete" do
    @event = Event.find_by_slug(params[:slug])
    erb :'events/delete_event'
  end

  delete "/events/:slug/delete" do
    @event = Event.find_by_slug(params[:slug])
    @user = User.find_by_id(session[:user_id])

    if @user == @event.user
      @event.delete
      redirect '/events'
    else
      redirect '/events'
    end
  end

end

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

end

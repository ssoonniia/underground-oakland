class EventsController < ApplicationController

  get '/events' do
    erb :'events/events'
  end

end

jack = User.create(username:'Jack', email:'jack@test.com', password: 'rabbit123' )
tour = Event.create(name: 'Street Art Walking Tour', date: 'Saturday', location:'14th and Broadway' description: 'Join us Saturday morning at 9am for a free street art walking tour. Our guide will be waiting infront of the Wine Shop', cost: 'free')
tour.user = jack




sonia = User.create(username:'Sonia', email: 'sonia@test.com', password: 'test')
first_fridays = Event.create(name: 'First Fridays', date: 'friday', location: 'Telegraph Avenue', description: 'Oakland First Fridays is an immersive art and community experience on the first Friday of each month on Telegraph Avenue from West Grand to 27th Street. Every First Friday from 5–9:00 pm, Oaklands KONO district springs to life with for this event, with galleries, artist collectives, street artists, local culinary artisans, performers, musicians, dancers, DJ’s, and poets gathering for Oakland First Friday events', cost:'$5.00 suggested donation')
first_fridays.user= sonia



restaurant_week = Event.create(name: 'Restaurant Week', date: 'Sunday', location: 'All over oakland', description: 'Oakland will be hosting Restaurant Week.' cost: 'varies')
restaurant_week.user = sonia

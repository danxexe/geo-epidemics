GeoEpidemics
============

A Geographical Information System demo for displaying epidemics data.


Live Demo
---

http://geo-epidemics.danx.in/

The Demo App is hosted on [Heroku](http://www.heroku.com) and the database on [MongoHQ](https://mongohq.com).


Architecture
---

![Architecture](https://github.com/danxexe/geo-epidemics/raw/master/public/network-graph.png)

The Demo consists of a HTML / Javascript client and a Ruby on Rails backend exposing a RESTful webservice using JSON format and MongoDB for data storage. The client combines tagged information about locations retrieved form the webservice with a geographical map using the Google Maps API.


Tech
---

- [Ruby](http://www.ruby-lang.org)
- [Rails](http://rubyonrails.org)
- [CoffeeScript](http://coffeescript.or/)
- [Slim](http://slim-lang.com)
- [MongoDB](http://www.mongodb.org) with [Mongoid](http://mongoid.org)
- [Google Maps API](https://developers.google.com/maps) with [gmaps.js](http://hpneo.github.com/gmaps)
- [JSON](http://www.json.org)


App usage
---

- You can zoom in, zoom out and pan the map, like in Google maps.
- Click on an empty space on the map to insert a tagged location.
- Use the tag selection box on the bottom left corner to switch tags.
- Select the last option with a red X on the tag selection box to enter delete mode.
- Click on a location when in delete mode to remove that tagged location.
- Drag the slider on the bottom right box to change the radius of all location markers.
- Click on a tag name to show / hide all locations with that tag.
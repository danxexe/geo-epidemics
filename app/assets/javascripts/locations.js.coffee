window.Location = class Location

  constructor: (options = {}) ->

    @position = options['position']
    @tag = options['tag']

    @marker = options['marker']

  attributes: ->
    { location: { position: @position, tag: @tag } }

  save: ->
    $.post('/locations.json', @attributes())

  @load: (callback) ->
    $.getJSON '/locations.json', (data) ->

      $.each data, (k,v) ->
        location = new Location(v)
        Location.all().push location

      callback(Location.all())

  @all: ->
    @locations ||= []

  @create: (options = {}) ->
    location = new Location(options)
    Location.all().push location

    location.save()

    location

$ ->
  window.map = new GMaps
    div: '#map'
    zoom: 12
    lat: -25.421881
    lng: -49.272652
    click: (e) ->
      location = Location.create
        position: [e.latLng.lat(), e.latLng.lng()]
        tag: 'red'

      map.addLocationMarker location        

  map.addLocationMarker = (location) ->
    circle = map.drawCircle
      lat: location.position[0]
      lng: location.position[1]
      radius: 200
      strokeColor: "#FF0000"
      strokeOpacity: 0.8
      strokeWeight: 1
      fillColor: "#FF0000"
      fillOpacity: 0.35

    location.marker = circle
    circle


  # load existing locations

  Location.load (locations) ->
    $.each locations, (i, location) ->
      map.addLocationMarker location
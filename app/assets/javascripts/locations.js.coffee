# Location clent-side model

window.Location = class Location

  constructor: (options = {}) ->

    @position = options['position']
    @tag = options['tag']

    @marker = options['marker']

  attributes: ->
    { location: { position: @position, tag: @tag } }

  save: ->
    $.post('/locations.json', @attributes())

  destroy: ->
    $.ajax
      dataType: 'json'
      type: 'DELETE'
      url: '/locations/by-position.json'
      data: @attributes()

    Location.locations.splice _.indexOf(Location.locations, @), 1
    Location.locations_by_tag[@.tag].splice _.indexOf(Location.locations_by_tag[@.tag], @), 1

  @load: (callback) ->
    $.getJSON '/locations.json', (data) ->

      $.each data, (k,v) ->
        location = new Location(v)
        Location.all().push location
        Location.by_tag(location.tag).push location

      callback(Location.all())

  @all: ->
    @locations ||= []

  @by_tag: (tag) ->
    @locations_by_tag ||= {}
    @locations_by_tag[tag] ||= []

  @create: (options = {}) ->
    location = new Location(options)
    Location.all().push location

    location.save()

    location


# Initialize map

$ ->
  window.map = new GMaps
    div: '#map'
    zoom: 12
    lat: -25.421881
    lng: -49.272652
    click: (e) ->
      location = Location.create
        position: [e.latLng.lat(), e.latLng.lng()]
        tag: $('#tools .selected').data('tag')

      map.addLocationMarker location

  map.colors = 
    'suspeita-foco': '#9595c9'
    'foco': '#983794'
    'suspeita-caso': '#f8991d'
    'caso': '#cb2027'

  map.addLocationMarker = (location) ->
    circle = map.drawCircle
      lat: location.position[0]
      lng: location.position[1]
      radius: (Number) $('#marker-radius-picker').val()
      strokeColor: map.colors[location.tag]
      fillColor: map.colors[location.tag]
      strokeOpacity: 1.0
      fillOpacity: 0.8
      strokeWeight: 3
      click: map.markerCallback

    location.marker = circle
    circle.location = location
    circle

  map.markerCallback = ->
    if $('#tools .selected').data('action') == 'destroy'
      @.location.destroy()
      map.removeOverlay @


  # Load existing locations

  Location.load (locations) ->
    $.each locations, (i, location) ->
      map.addLocationMarker location


  # Change marker radius

  $('#marker-radius-picker').change (e) ->
    radius = (Number) $(@).val()

    $.each Location.all(), (i, location) ->
      location.marker.set('radius', radius )

    true


  # Show / hide tags

  $('#filters li').click ->
    $e = $(@)

    $e.toggleClass('disabled')

    $.each Location.by_tag($e.data('tag')), (i, location) ->
      location.marker.set('visible', !$e.hasClass('disabled'))

  # Change tag used on create

  $('#tools li').click ->
    $e = $(@)

    $('#tools li').removeClass('selected')
    $e.addClass('selected')
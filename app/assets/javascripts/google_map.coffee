App.Components ||= {}

class App.Components.Gmap
  constructor: (@el) ->

  render: ->
    mapOptions =
      zoom: 14
      center: @_currentPosition()

    map = new google.maps.Map(@el, mapOptions)

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) =>
        map.setCenter(@_parsePosition(position))
    map

  _parsePosition: (data) ->
    lat: data.coords.latitude
    lng: data.coords.longitude

  _currentPosition: ->
    lat: App.currentLocation.latitude
    lng: App.currentLocation.longitude

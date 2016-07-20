class @GoogleMap
  map: {}
  markers: []

  _authorInfoTemplate: (options) ->
    JST["author_info"](options)

  constructor: (entities) ->
    @entities = entities
    @showContents(entities)
    @initMap()

  initMap: ->
    if $('#map').length > 0
      currentLatLng =
        lat: App.currentLocation.latitude
        lng: App.currentLocation.longitude
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position) =>
          latLng =
            lat: position.coords.latitude
            lng: position.coords.longitude
          @showMainMap(latLng)
      else
        @showMainMap(currentLatLng)

  showMainMap: (position) ->
    mapOptions =
      zoom: 14
      center: position

    @map = new (google.maps.Map)(document.getElementById('map'), mapOptions)
    @map.setCenter(position)
    @addMarker(position)
    @setMapOnAll(@map)

  addMarker: (location) ->
    marker = new (google.maps.Marker)(
      position: location
      map: @map
    )
    @markers.push marker
    marker

  setUpMarkers: (entities) ->
    $.each entities, (index, entity) =>
      latLng = { lat: entity.location.latitude, lng: entity.location.longitude }
      @addMarker(latLng)

  setMapOnAll: (map) ->
    i = 0
    while i < @markers.length
      @markers[i].setMap map
      i++

  clearMarkers: ->
    @setMapOnAll null
    @markers = []

  showMarkers: ->
    @setMapOnAll @map

  deleteMarkers: ->
    @clearMarkers()
    @markers = []

  showContent: (marker, entity) ->
    authorInfo = @_authorInfoTemplate(entity: entity)
    infowindow = new (google.maps.InfoWindow)(content: authorInfo)
    marker.addListener 'click', ->
      infowindow.open(@map, marker)

  showContents: (entities) ->
    $.each entities, (index, entity) =>
      latLng = { lat: entity.location.latitude, lng: entity.location.longitude }
      marker = @addMarker(latLng)
      @showContent(marker, entity)

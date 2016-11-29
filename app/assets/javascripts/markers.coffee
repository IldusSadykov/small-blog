App.Components ||= {}

class App.Components.Markers
  _authorInfoTemplate: (options) ->
    JST["author_info"](options)

  constructor: (@map) ->
    @_bindEvents()

    @markers = []
    @infoWindows = []

    @_showMarkers(App.authors)

  _bindEvents: ->
    $(document).on "app:search_authors:done", (event, authors) =>
      @_deleteMarkers()
      @_showMarkers(authors)

    $(document).on "app:search_author:done", (event, author) =>
      @_deleteMarkers()
      @_showMarker(author)

  _addMarker: (location) =>
    marker = new google.maps.Marker(
      position: location
      map: @map
    )
    @markers.push marker
    marker

  _showMarker: (author) ->
    marker = @_addMarker(@_parsePosition(author.location))
    marker.addListener 'click', =>
      @_showContent(marker, author)
    @map.panTo(marker.getPosition())

  _showMarkers: (authors) ->
    $.map authors, (author, i) =>
      @_showMarker(author)

  _parsePosition: (location) ->
    lat: location.latitude
    lng: location.longitude

  _showContent: (marker, entity) ->
    @_closeInfoWindows()
    authorInfo = @_authorInfoTemplate(entity: entity)
    infowindow = @_createInfoWindow(authorInfo).open(@map, marker)
    infowindow.open(@map, marker)

  _createInfoWindow: (content) ->
    infoWindow = new google.maps.InfoWindow(content: content)
    @infoWindows.push(infoWindow)
    infoWindow

  _deleteMarkers: ->
    @_clearMarkers()
    @_closeInfoWindows()
    @markers = []
    @infoWindows = []

  _clearMarkers: ->
    @markers.forEach (marker, i) ->
      marker.setMap(null)

  _closeInfoWindows: ->
    @infoWindows.forEach (box, i) ->
      box.close()

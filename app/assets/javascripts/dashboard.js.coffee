class @Dashboard
  constructor: ->
    @locations = window.authors_coordinates
    @bindEvents()
    @showAuthorsInMap()

  bindEvents: ->

  showAuthorsInMap: ->
    $.each @locations, (index, location) =>
      @showMarker(location)


  showMarker: (location) ->
    latLng = { lat: location.lat, lng: location.lng }
    marker = new (google.maps.Marker)(
      position: latLng
      title: 'Hello World!')
    marker.setMap(map)
    @showContent(marker, location)

  showContent: (marker, location) ->
    contentString =
      '<div id="content">' + '<div id="siteNotice">' + '</div>' +
      '<h3 id="firstHeading" class="firstHeading">Author ' + location.user_name + '</h3>' +
      '<div id="bodyContent">' + '<p>' + location.user_name + ' <a href=' + location.user_posts + ' target="_blank">posts</a></p>' + '</div>' +
      '</div>'
    infowindow = new (google.maps.InfoWindow)(content: contentString)
    marker.addListener 'click', ->
      infowindow.open(map, marker)

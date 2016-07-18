class @Dashboard
  POSTS_URL = "/posts"

  markers: []

  constructor: ->
    @authors_with_locations = window.authors_with_locations
    @bindEvents()
    @showAuthorsInMap(@authors_with_locations)

  ui: ->
    postsList: $("#posts-list")

  _postTemplate: (options) ->
    JST["post_item"](options)

  bindEvents: ->
    $(".search_users").on "keyup", (event) =>
      target = event.currentTarget
      promise = $.ajax
        url: POSTS_URL
        method: "GET"
        dataType: "json"
        data:
          query: $(target).val()
        success: (data) =>
          @clearMarkers()
          @ui().postsList.html('')
          $.each data.posts, (index, post) =>
            @renderPost(post)
            @showMarker(post.author)

  showAuthorsInMap: (users_with_locations) ->
    $.each users_with_locations, (index, uwl) =>
      @showMarker(uwl)

  showMarker: (user) ->
    latLng = { lat: user.location.latitude, lng: user.location.longitude }
    marker = new (google.maps.Marker)(
      position: latLng
      title: 'Hello World!')
    marker.setMap(map)
    @markers.push(marker)
    @showContent(marker, user)

  showContent: (marker, user) ->
    contentString =
      '<div id="content">' + '<div id="siteNotice">' + '</div>' +
      '<h3 id="firstHeading" class="firstHeading">Author ' + user.name + '</h3>' +
      '<div id="bodyContent">' + '<p>' + user.name + ' <a href="/users/' + user.id + '/posts" target="_blank">posts</a></p>' + '</div>' +
      '</div>'
    infowindow = new (google.maps.InfoWindow)(content: contentString)
    marker.addListener 'click', ->
      infowindow.open(map, marker)

  setMapOnAll: (map) ->
    i = 0
    while i < @markers.length
      @markers[i].setMap map
      i++
    return

  clearMarkers: ->
    @setMapOnAll null

  renderPost: (post) =>
    @ui().postsList.append(@_postTemplate(post: post))

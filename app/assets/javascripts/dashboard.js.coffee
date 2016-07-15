class @Dashboard
  POSTS_URL = "/posts"

  markers: []

  constructor: ->
    @locations = window.authors_coordinates
    @bindEvents()
    @showAuthorsInMap(@locations)

  ui: ->
    postsList: $("#posts-list")

  _postTemplate: (post) ->
    "<div class='post blog-post' id='#{post.id}'> \
       <h3> \
       <a href='/posts/#{post.id}'>#{post.title}</a> \
         <small>#{post.created_at}</small> \
       </h3> \
       <p>#{post.body}</p>
       <div class='callout'> \
         <ul class='menu simple'> \
           <li>Author: <a href='#'>#{post.user_name}</a></li> \
           <li>#{post.created_at}</li>\
         </ul> \
       </div> \
     </div>"

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
            @showMarker(post)

  showAuthorsInMap: (locations) ->
    $.each locations, (index, location) =>
      @showMarker(location)

  showMarker: (location) ->
    latLng = { lat: location.user_lat, lng: location.user_lng }
    marker = new (google.maps.Marker)(
      position: latLng
      title: 'Hello World!')
    marker.setMap(map)
    @markers.push(marker)
    @showContent(marker, location)

  showContent: (marker, location) ->
    contentString =
      '<div id="content">' + '<div id="siteNotice">' + '</div>' +
      '<h3 id="firstHeading" class="firstHeading">Author ' + location.user_name + '</h3>' +
      '<div id="bodyContent">' + '<p>' + location.user_name + ' <a href="/users/' + location.user_id + '/posts" target="_blank">posts</a></p>' + '</div>' +
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
    @ui().postsList.append(@_postTemplate(post))

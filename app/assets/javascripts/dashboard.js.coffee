class @Dashboard
  POSTS_URL = window.posts_path

  constructor: ->
    @googleMap = new GoogleMap(window.authors_with_locations)
    @bindEvents()

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
          @googleMap.clearMarkers()
          @ui().postsList.html('')
          $.each data.posts, (index, post) =>
            @renderPost(post)
            author = post.author
            location = author.location
            latLng = {
              lat: location.latitude
              lng: location.longitude
            }
            marker = @googleMap.addMarker(latLng)
            @googleMap.showContent(marker, author)

  renderPost: (post) =>
    @ui().postsList.append(@_postTemplate(post: post))

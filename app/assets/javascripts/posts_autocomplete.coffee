App.Components ||= {}

class App.Components.PostsAutocomplete
  POSTS_URL = window.posts_path

  constructor: (@$el) ->
    @googleMap = new GoogleMap(window.authors_with_locations)
    @initAutocomplete()

  initAutocomplete: ->
    @$el.autocomplete
      serviceUrl: POSTS_URL
      dataType: "json"
      transformResult: (response) ->
        suggestions: $.map(response.posts, (post) ->
          {
            value: post.title,
            data: post.id,
            author: post.author
          }
        )
      onSearchComplete: (query, posts) =>
        @googleMap.clearMarkers()
        $.each posts, (index, post) =>
          @showAuthor(post.author)

      onSelect: (post) =>
        @googleMap.clearMarkers()
        @showAuthor(post.author)

  showAuthor: (author) =>
    location = author.location
    if location
      latLng = {
        lat: location.latitude
        lng: location.longitude
      }
      marker = @googleMap.addMarker(latLng)
      @googleMap.showContent(marker, author)

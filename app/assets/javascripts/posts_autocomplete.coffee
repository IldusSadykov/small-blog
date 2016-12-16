App.Components ||= {}

class App.Components.PostsAutocomplete
  POSTS_URL = window.posts_path

  constructor: (@$el) ->
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
        authors = posts.map (post) -> return post.author
        $(document).trigger("app:search_authors:done", [authors])

      onSelect: (post) =>
        author = post.author
        $(document).trigger("app:search_author:done", author)

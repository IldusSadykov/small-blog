App.Components ||= {}

class App.Components.SearchAuthors
  constructor: (@$input) ->
    @bindEvents()

  bindEvents: ->
    @$input.on "typeahead:select", @searchSelection
    @$input.on "typeahead:autocomplete", @searchAutocomplete
    @$input.on "input", @performBlankSearch

  searchSelection: (event, query) =>
    @search(query.title)

  searchAutocomplete: (event, query) =>
    @search(query.title)
    @$input.typeahead("close")

  performBlankSearch: (event) =>
    if !event.target.value.length
      @search("")

  search: (query) ->
    $.get("/users/search", query: query).done((data) ->
      $(document).trigger("app:search_authors:done", [data.users])
    ).fail ->
      console.error "Search error."

# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery_ujs
#= require foundation
#= require current_user
#= require skim
#= require_tree ../templates
#= require_tree .

$ ->
  $(document).foundation()

  window.Comments = new Comments
  window.FlashMessages = new App.Components.FlashMessages

  $searchInput = $(".search_users")
  $closeButton = $("button.close")
  $deleteSubscription = $(".delete-subscription")

  if $searchInput.length
    postAutocomplete = new App.Components.PostsAutocomplete($searchInput)
    mapEl = document.getElementById('map')

    if document.body.contains(mapEl)
      googleMap = (new App.Components.Gmap(mapEl)).render()
      markers = new App.Components.Markers(googleMap)

  $closeButton.on "click", ->
    @parentNode.remove()

  if $deleteSubscription
    new App.Components.DeleteSubscription($deleteSubscription)

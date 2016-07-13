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
  myLatLng =
    lat: window.userLat
    lng: window.userLng

  mapOptions =
    zoom: 14
    center: myLatLng

  if $('#map').length > 0
    window.map = new (google.maps.Map)(document.getElementById('map'), mapOptions)

    marker = new (google.maps.Marker)(
      position: myLatLng
      map: map
    )

    window.Dashboard = new Dashboard

  window.Comments = new Comments

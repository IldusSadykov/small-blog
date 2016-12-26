App.Components ||= {}

class App.Components.DeleteSubscription
  constructor: (@el) ->
    @bindEvents()

  bindEvents: ->
    @el.on "click", (event) ->
      event.preventDefault()
      target = event.currentTarget

      $.ajax
        type: "DELETE"
        dataType: "json"
        url: target.href
        success: (response) ->
          target.parentNode.remove()
          $(document).trigger(
            "app:request:done",
            {
              message: response.message,
              type: "notice"
            }
          )

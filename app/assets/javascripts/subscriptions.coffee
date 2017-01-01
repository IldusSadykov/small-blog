App.Components ||= {}

class App.Components.DeleteSubscription
  constructor: (@el) ->
    @bindEvents()

  bindEvents: ->
    @el.on "click", (event) ->
      event.preventDefault()
      target = $(event.currentTarget)

      $.ajax
        type: "DELETE"
        dataType: "json"
        url: target.prop("href")
        success: (response) ->
          target.parent().remove()
          $(document).trigger(
            "app:request:done",
            {
              message: response.message,
              type: "notice"
            }
          )

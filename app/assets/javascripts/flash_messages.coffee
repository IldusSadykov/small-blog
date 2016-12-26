App.Components ||= {}

class App.Components.FlashMessages
  constructor: ->
    @_bindEvents()

  _flashTemplate: (options) ->
    JST["messages_template"](options)

  ui:
    topBar: $(".top-bar")

  _bindEvents: ->
    $(document).on "app:request:done", @render

  render: (event, options) =>
    { @message, @type } = options
    options =
      message: @message
      type: @type
    @ui.topBar.next(".alert-box.notice").remove()
    @ui.topBar.after(@_flashTemplate(options))

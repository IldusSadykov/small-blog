class @Comments
  constructor: ->
    @bindEvents()

  ui:
    commentAdd: $('.comment-add')
    createButton: $('input.comment-save')
    commentForm: $('.comment-area')

  bindEvents: ->
    @ui.commentAdd.on 'click', (event) =>
      event.preventDefault()
      @ui.commentForm.slideToggle()

    @ui.createButton.on 'click', (event) =>
      event.preventDefault()

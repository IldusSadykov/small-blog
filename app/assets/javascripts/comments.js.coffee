class @Comments
  constructor: ->
    @bindEvents()

  ui:
    commentAdd: $('.comment-add')
    createButton: $('input.comment-save')
    commentForm: $('.comment-area')
    currentPostId: $('.current-post').attr('id')
    form: $('form.new_comment')
    commentsList: $('.comments-list')
    deleteButton: $('.button.delete-comment')

  _commentTemplate: (options) ->
    JST["comment_item"](options)

  bindEvents: ->
    @ui.commentAdd.on 'click', (event) =>
      event.preventDefault()
      @ui.commentForm.slideToggle()

    @ui.createButton.on 'click', (event) =>
      event.preventDefault()
      @createComment(event)

    @ui.deleteButton.on 'click', (event) =>
      @deleteComment(event)

  createComment: ->
    $.ajax
      type: "POST"
      dataType: "json"
      url: @ui.form.prop("action")
      data:
        comment:
          message: @ui.form.find("textarea[name='comment[message]']").val()
      success: (response) =>
        @renderComment(response)
        @ui.commentForm.slideToggle()
        @ui.form.find("textarea[name='comment[message]']").val('')

  renderComment: (data) ->
    options =
      comment_id: data.id
      message: data.message
      user_name: data.user_name
      created_at: data.created_at
      comment_path: data.comment_path
    @ui.commentsList.prepend(@_commentTemplate(options))
    @bindEvents()

  deleteComment: (event) ->
    event.stopPropagation()
    event.preventDefault()
    target = $(event.currentTarget)
    $.ajax
      type: "DELETE"
      dataType: "json"
      url: target.prop("href")
      success: (response) ->
        target.parent().remove()
        $(document).trigger("app:request:done", { message: response.message, type: "notice"} )

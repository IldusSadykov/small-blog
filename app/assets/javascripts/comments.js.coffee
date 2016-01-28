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

  _commentTemplate: (options) ->
    #JST["comments/item"](options)
    { message, author, created_at } = options
    "<div class='row'> \
      <div class='large-12 columns'> \
        <span class='message'>#{message}</span> \
        <h5>#{author}</h5> \
        <p>#{created_at}</p> \
        <hr>\
      </div>\
     </div>"

  bindEvents: ->
    @ui.commentAdd.on 'click', (event) =>
      event.preventDefault()
      @ui.commentForm.slideToggle()

    @ui.createButton.on 'click', (event) =>
      event.preventDefault()
      @createComment(event)

  createComment: ->
    $.ajax
      type: 'POST'
      url: "/posts/#{@ui.currentPostId}/comments"
      data:
        comment:
          message: @ui.form.find("textarea[name='comment[message]']").val()
      success: (response) =>
        @renderComment(response)
        @ui.commentForm.slideToggle()
        @ui.form.find("textarea[name='comment[message]']").val('')

  renderComment: (data) ->
    options =
      message: data.message
      author: data.author
      created_at: data.created_at
    @ui.commentsList.prepend(@_commentTemplate(options))

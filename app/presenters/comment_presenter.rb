class CommentPresenter < BasePresenter
  def author
    @object.user.full_name
  end
end

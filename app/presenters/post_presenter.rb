class PostPresenter < BasePresenter
  def author
    @object.user.full_name
  end

  def all_comments
    CommentPresenter.wrap(@object.comments.order('created_at desc'))
  end
end

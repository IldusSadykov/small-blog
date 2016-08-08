class Dashboard
  attr_reader :current_location, :user

  def initialize(current_location, user)
    @current_location = current_location
    @user = user
  end

  def authors
    authors = FetchAuthorsNearby.call(current_location: current_location).authors
    authors.compact.map do |author|
      UserSerializer.new(author, root: false)
    end
  end

  def posts
    @posts ||= PostDecorator.decorate_collection(posts_users)
  end

  def categories
    @categories ||= Category.all
  end

  private

  def posts_users
    @posts_users ||= PostUserWrapper.wrap(Post.all_cached, user)
  end
end

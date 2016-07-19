class Dashboard
  attr_reader :user, :request_location

  def initialize(user, request_location)
    @user = user
    @request_location = request_location
  end

  def authors
    authors = AuthorsNearby.call(user: user, current_location: request_location).authors
    authors.compact.map do |author|
      UserSerializer.new(author, root: false)
    end
  end

  def posts
    @posts ||= PostDecorator.decorate_collection(Post.all_cached)
  end

  def categories
    @categories ||= Category.all
  end
end

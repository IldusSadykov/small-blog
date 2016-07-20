class Dashboard
  attr_reader :current_location

  def initialize(current_location)
    @current_location = current_location
  end

  def authors
    authors = FetchAuthorsNearby.call(current_location: current_location).authors
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

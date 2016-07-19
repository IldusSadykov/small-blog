class PostsWithQuery
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def all
    return Post.all_cached if query.blank?
    Post.includes(:user)
      .where('body ilike :query or title ilike :query', query: "%#{query}%")
  end
end

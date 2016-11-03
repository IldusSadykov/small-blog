class PostsWithQuery
  attr_reader :query

  POST_COUNT = 10

  def initialize(query)
    @query = query
  end

  def all
    return Post.all_cached if query.blank?
    Post
      .where("body ilike :query or title ilike :query", query: "%#{query}%")
      .limit(POST_COUNT)
  end
end

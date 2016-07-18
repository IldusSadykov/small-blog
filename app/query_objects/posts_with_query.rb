class PostsWithQuery
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def all
    return Post.none if query.blank?
    Post.includes(:user)
      .where('body ilike ?', "%#{query}%")
  end
end

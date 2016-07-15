class PostsWithUserLocation
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def all
    return Post.none if query.blank?
    fetch_posts(query)
  end

  private

  def fetch_posts(text)
    Post.joins(user: :location)
      .where('body ilike ?', "%#{text}%")
      .select("posts.*, locations.lat as user_lat, locations.lon as user_lng, users.full_name as user_name")
  end
end

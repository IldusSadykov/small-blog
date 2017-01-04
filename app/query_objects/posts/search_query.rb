module Posts
  class SearchQuery
    attr_reader :query

    POST_COUNT = 10

    def initialize(query)
      @query = query
    end

    def all
      Post.includes(author: :location).search_full_text(query).limit(POST_COUNT)
    end
  end
end

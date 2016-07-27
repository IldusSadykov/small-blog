class FetchAuthorsNearby
  include Interactor

  DEFAULT_DISTANCE = 10

  delegate :current_location, to: :context

  def call
    context.authors = locations.includes(:user).map(&:user)
  end

  private

  def locations
    LocationNearby.new(current_location, DEFAULT_DISTANCE).all
  end
end

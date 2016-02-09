class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end

  def created_at
    object.created_at.strftime('%B %d, %Y %H:%M')
  end
end

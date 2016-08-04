class PostUserDecorator < SimpleDelegator
  attr_reader :user
  private :user

  def initialize(obj)
    @user = obj[1]
    super(obj[0])
  end

  def self.wrap(collection, user)
    collection.map do |obj|
      new [obj, user]
    end
  end

  def subscribed?
    return false if owner? or user.blank?
    user.subscriptions.map(&:plan).include?(plan)
  end

  def owner?
    author == user
  end

  def model_name
    "Post"
  end
end

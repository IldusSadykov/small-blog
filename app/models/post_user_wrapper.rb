class PostUserWrapper < SimpleDelegator
  attr_reader :user
  private :user

  def initialize(post, user)
    @user = user
    super(post)
  end

  def self.wrap(posts, user)
    posts.map do |post|
      new(post, user)
    end
  end

  def subscribed?
    user.subscription_plans.include?(self.plan)
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Post")
  end
end

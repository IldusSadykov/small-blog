class PostPolicy < ApplicationPolicy
  def read?
    owner? || record.plan.blank? || record.subscribed?(user)
  end

  def subscribed?
    record.subscribed?(user)
  end

  def can_subscribe?
    record.plan && !owner? && !record.subscribed?(user)
  end


  def edit?
    owner?
  end

  def update?
    edit? && !record.published?
  end

  def delete?
    owner?
  end

  private

  def owner?
    record.author == user
  end
end

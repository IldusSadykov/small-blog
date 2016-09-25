class PostPolicy < ApplicationPolicy
  def read?
    record.plan.blank? || owner? || record.subscribed?(user)
  end

  def can_subscribe?
    record.plan && !owner? && !record.subscribed?(user)
  end

  def edit?
    owner?
  end

  def update?
    edit? && (not record.published?)
  end

  def delete?
    owner?
  end

  private

  def owner?
    record.author == user
  end
end

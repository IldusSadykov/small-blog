class PostPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def update?
    edit? && (not record.published?)
  end

  def delete?
    owner?
  end

  def subscribed_by_user
    return true if owner?
    user.subscriptions.map(&:plan).include?(record.plan)
  end
end

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

  def read?
    if subscribed_by_user?
      true
    else
      if record.plan.blank?
        return true
      else
        false
      end
    end
  end

  def subscribed_by_user?
    return false if owner? or user.blank?
    user.subscriptions.map(&:plan).include?(record.plan)
  end

  def owner?
    record.author == user
  end
end

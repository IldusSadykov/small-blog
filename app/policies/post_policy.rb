class PostPolicy < ApplicationPolicy
  def read?
    record.plan.blank? || owner? || record.subscribed?
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

  def owner?
    record.author == user
  end
end

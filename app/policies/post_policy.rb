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
    record.subscribed? || record.plan.blank?
  end

  def owner?
    record.author == user
  end
end

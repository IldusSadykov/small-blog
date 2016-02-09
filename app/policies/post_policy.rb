class PostPolicy < ApplicationPolicy
  def read?
    record.published?
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
end

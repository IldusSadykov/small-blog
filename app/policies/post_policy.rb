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
end

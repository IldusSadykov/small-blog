class PostPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def update?
    edit? && (not object.published?)
  end

  def delete?
    owner?
  end
end

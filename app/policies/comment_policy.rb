class CommentPolicy < ApplicationPolicy
  def edit?
    owner?
  end

  def delete?
    owner?
  end
end

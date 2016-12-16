class CommentPolicy < ApplicationPolicy
  def delete?
    owner?
  end
end

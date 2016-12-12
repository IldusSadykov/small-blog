module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:warning] =  "Not allowed to access to this resource, please subscribe"
    redirect_to(root_path)
  end
end

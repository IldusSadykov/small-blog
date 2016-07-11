class Users::RegistrationsController < Devise::RegistrationsController
  private

  def account_update_params
    params.require(:user).permit(
      :full_name,
      :email,
      :password,
      :password_confirmation,
      :current_password,
      location_attributes: %i(street city state country_id)
    )
  end
end

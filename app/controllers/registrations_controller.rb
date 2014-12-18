class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    land_path
  end

  private
 
    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :btc_address, :ticket)
    end
 
    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :btc_address, :ticket)
    end
end
class RegistrationsController < Devise::RegistrationsController
  protected

    def after_sign_up_path_for(resource)
      edit_user_registration_path
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      hacker_profile_path(resource.slug)
    end

  private

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :btc_address, :ticket, :checked_in, :team_id, :bio, :twitter)
    end

    def account_update_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :btc_address, :ticket, :checked_in, :team_id, :bio, :twitter)
    end
end

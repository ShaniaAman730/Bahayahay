class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]


  # GET /resource/sign_up
  def new
     super
  end

  # POST /resource
  def create
    super
      #if user.persisted?
        #UserMailer.welcome_email(user).deliver_now
        #user.update_column(:welcome_email_sent_at, Time.current)
      #end
    #end
  end

  # GET /resource/edit
  def edit
     @tab = params[:tab] || "profile"  # default to profile
     super
  end

  # PUT /resource
  def update
   if !current_user.admin?
      params[:user].delete(:role) # forcibly strip forbidden fields
   end
     super
  end

  protected

def update_resource(resource, params)
  # Remove current_password (and empty password fields) before updating
  clean_params = params.except(:current_password)
  clean_params[:password] = nil if clean_params[:password].blank?
  clean_params[:password_confirmation] = nil if clean_params[:password_confirmation].blank?

  if params[:current_password].blank?
    resource.update_without_password(clean_params)
  else
    super
  end
end


  def after_update_path_for(resource)
    user_path(resource)  
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :contact_no, :user_type, :company_name, :address, :admin_approved, :prc_no, :dhsud_no, :is_broker, :broker_name, :broker_prc_no, :privacy_agreement, :profile_photo, :prc_id, :dhsud_cert, :gov_id])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
      if current_user.admin?
         devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :contact_no, :user_type, :company_name, :address, :admin_approved, :prc_no, :dhsud_no, :about, :website, :is_broker, :broker_name, :broker_prc_no, :privacy_agreement, :profile_photo, :prc_id, :dhsud_cert, :gov_id])
      else
         devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :contact_no, :company_name, :address, :admin_approved, :prc_no, :dhsud_no, :about, :website, :is_broker, :broker_name, :privacy_agreement, :broker_prc_no, :profile_photo, :prc_id, :dhsud_cert, :gov_id])
      end
  end

  # DELETE /resource
  def destroy
     super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
     super
  end


  # The path used after sign up.
  def after_sign_up_path_for(resource)
     super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
     super(resource)
  end

end

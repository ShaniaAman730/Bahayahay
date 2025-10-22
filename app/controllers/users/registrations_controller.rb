class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/edit
  def edit
    @tab = params[:tab] || "profile"
    super
  end

  # PUT /resource
  def update
    if !current_user.admin?
      params[:user].delete(:role)
    end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").id)

    respond_to do |format|
      if update_resource(resource, account_update_params)
        flash[:notice] = "Profile updated successfully."
        bypass_sign_in resource, scope: resource_name

        format.html { redirect_to user_path(resource) }

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "flash-messages",
            partial: "layouts/flash"
          )
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        flash.now[:alert] = resource.errors.full_messages.join(", ")

        format.html { render :edit, status: :unprocessable_entity }

        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "flash-messages",
            partial: "layouts/flash"
          )
        end
      end
    end
  end

  protected

  def update_resource(resource, params)
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

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name, :last_name, :contact_no, :user_type, :company_name,
      :address, :admin_approved, :prc_no, :dhsud_no, :is_broker,
      :broker_name, :broker_prc_no, :privacy_agreement, :profile_photo,
      :prc_id, :dhsud_cert, :gov_id
    ])
  end

  def configure_account_update_params
    allowed = [
      :first_name, :last_name, :contact_no, :company_name, :address,
      :admin_approved, :prc_no, :dhsud_no, :about, :website,
      :is_broker, :broker_name, :broker_prc_no, :privacy_agreement,
      :profile_photo, :prc_id, :dhsud_cert, :gov_id
    ]
    allowed << :user_type if current_user.admin?
    devise_parameter_sanitizer.permit(:account_update, keys: allowed)
  end
end

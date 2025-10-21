class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_admin!
  before_action :set_user, only: [:reset_password]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to all_users_users_path, notice: "User created successfully."
    else
      flash[:alert] = "User could not be created: #{@user.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def reset_password
    new_password = Devise.friendly_token.first(10)
    @user.password = new_password
    @user.password_confirmation = new_password

    if @user.save

      PasswordResetLog.create!(
        admin: current_user,
        user: @user,
        new_password: new_password
      )

      redirect_to all_users_users_path, notice: "Password reset for #{@user.email}. New password: #{new_password}"
    else
      redirect_to all_users_users_path, alert: "Could not reset password: #{@user.errors.full_messages.join(', ')}"
    end
  end

  private

  def ensure_admin!
    redirect_to root_path unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,:first_name, :last_name, :contact_no, :user_type, :company_name, :address, :admin_approved, :profile_photo)
  end
end

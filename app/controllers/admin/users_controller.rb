class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_admin!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to all_users_users_path, notice: "User created successfully."
    else
      flash[:alert] = "User could not be created: #{@user.errors.full_messages.join(", ")}"
      render :new
    end
  end

  private

  def ensure_admin!
     redirect_to root_path unless current_user.admin?
    end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                :first_name, :last_name, :contact_no, 
                                :user_type, :company_name, :address, 
                                :admin_approved, :profile_photo)
  end
end


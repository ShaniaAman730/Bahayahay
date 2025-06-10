class UserManagementController < ApplicationController
	before_action :authenticate_admin!
  before_action :ensure_admin!

    def managerealtors
      @users = User.all
      @user_counter = 0

      if params[:query].present?
        query = "%#{params[:query].downcase}%"
       @users = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(company_name) LIKE ?", query, query, query, query)
      else
        @users = User.all
      end
    end

    def index
      @users = User.all

      if params[:query].present?
        query = "%#{params[:query].downcase}%"
       @users = User.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ? OR LOWER(company_name) LIKE ?", query, query, query, query)
      else
        @users = User.all
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

	  def create
      @user = User.new(user_params) # Use strong parameters for security
      if @user.save && @user.developer?
        redirect_to user_management_index_path, notice: "User created successfully."
      elsif @user.save && @user.realtor?
        redirect_to '/managerealtors', notice: "User updated successfully."
      else
        flash[:alert] = "User could not be created: #{@user.errors.full_messages.join(", ")}"
        render :new # Render the new user form again
      end
    end

    def update
      @user = User.find(params[:id])

      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if @user.update(user_params) && @user.developer?
        redirect_to user_management_index_path, notice: "User updated successfully."
      elsif @user.update(user_params) && @user.realtor?
        redirect_to '/managerealtors', notice: "User updated successfully."
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      if @user.destroy && @user.developer?
        redirect_to user_management_index_path, notice: "User deleted successfully."
      elsif @user.destroy && @user.realtor?
        redirect_to '/managerealtors', notice: "User deleted successfully."
      else
        redirect_to user_management_index_path, alert: "Could not delete user."
      end
    end

    private

    def ensure_admin!
     # Adjust this to match your logic for checking admin
     redirect_to root_path unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :contact_no, :user_type, :company_name, :address, :admin_approved, :profile_photo) # Add other fields as needed
    end

  
end

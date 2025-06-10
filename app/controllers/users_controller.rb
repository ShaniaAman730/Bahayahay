class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @listings = @user.listings_posted.page(params[:page]).per(5)
    
    if @user.admin? && !current_user.admin?
      redirect_to root_path, notice: "User's profile is not available."
    end  
  end

end

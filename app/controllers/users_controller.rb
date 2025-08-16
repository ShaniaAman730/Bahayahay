class UsersController < ApplicationController
  
  before_action :authenticate_realtor_developer!
  before_action :ensure_realtor_developer!

  skip_before_action :authenticate_realtor_developer!, only: [:show]
  skip_before_action :ensure_realtor_developer!, only: [:show]

  def show
    @user = User.find(params[:id])
    @listings = @user.listings_posted.merge(Listing.approved_listings).page(params[:listings_page]).per(3)
    @dev_projects = DevProject.page(params[:dev_projects_page]).order(created_at: :desc).per(3)
    @reviews = @user.received_reviews.page(params[:reviews_page]).per(3)

    
    if @user.admin? && !current_user.admin?
      redirect_to root_path, notice: "User's profile is not available."
    end  
  end

  def reviews
    @user = User.find(params[:id])
    
    unless @user.realtor? || @user.developer?
      redirect_to user_path(@user), alert: "This user does not have public reviews."
      return
    end

    @reviews = @user.received_reviews.order(created_at: :desc).page(params[:page]).per(5)
  end

  private 

  def ensure_realtor_developer!
     redirect_to root_path unless current_user.realtor? || current_user.developer?
  end

end

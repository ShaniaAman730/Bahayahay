class HomeController < ApplicationController
  def index
    @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
    @recent_guides = Guide.order(created_at: :desc).limit(9)
    if current_user&.client?
      @recent_saved_listings = current_user.saved_listings.includes(:listing).order(created_at: :desc).limit(9).map(&:listing)
    end
    @dev_projects = DevProject.page(params[:dev_projects_page]).order(created_at: :desc).per(5)
    @listings = Listing.page(params[:listings_page]).order(created_at: :desc).per(5)
  end

  def default_homepage
    @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
    @recent_guides = Guide.order(created_at: :desc).limit(9)
  end

end


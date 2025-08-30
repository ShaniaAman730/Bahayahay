class HomeController < ApplicationController
  def index

    if current_user&.client?
      @recent_saved_listings = current_user.saved_listings.includes(:listing).order(created_at: :desc).limit(9).map(&:listing)
      @recent_guides = Guide.order(created_at: :desc).limit(9)
    
    elsif current_user&.developer?
      @dev_projects = current_user.dev_projects.order(created_at: :desc).page(params[:dev_projects_page]).per(5)
      @recent_guides = current_user.guides.order(created_at: :desc).limit(9)

    elsif current_user&.realtor?
      @listings = current_user.listings_posted.order(created_at: :desc).page(params[:listings_page]).per(5)
      @recent_guides = current_user.guides.order(created_at: :desc).limit(9)

    else
      @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
      @recent_guides = Guide.order(created_at: :desc).limit(9)
    end

  end

  def default_homepage
    @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
    @recent_guides = Guide.order(created_at: :desc).limit(9)
  end

end


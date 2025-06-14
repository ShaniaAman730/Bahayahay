class HomeController < ApplicationController
  
  def index
    @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
  end

  def default_homepage
    @recent_listings = Listing.public_listings.order(created_at: :desc).limit(9)
  end
  
end




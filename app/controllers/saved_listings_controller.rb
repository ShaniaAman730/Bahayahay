class SavedListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!

  def index
    @saved_listings = current_user.saved_listings.includes(listing: :realtor).page(params[:page])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    current_user.saved_listings.create(listing: @listing)
    redirect_back fallback_location: listings_path, notice: "Listing saved."
  end

  def destroy
    saved_listing = current_user.saved_listings.find(params[:id])
    listing = saved_listing.listing
    saved_listing.destroy
    redirect_back fallback_location: listings_path, notice: "Listing removed from saved."
  end


  private

  def ensure_client!
    redirect_to root_path, alert: "Only clients can save listings." unless current_user.client?
  end
end

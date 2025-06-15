class SavedListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_client!

  def index
    @saved_listings = current_user.saved_listings.includes(listing: :realtor).page(params[:page])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    current_user.saved_listings.create(listing: @listing)
    redirect_to @listing, notice: "Listing saved."
  end

  def destroy
    saved_listing = current_user.saved_listings.find_by(listing_id: params[:listing_id])
    saved_listing.destroy if saved_listing
    redirect_to listing_path(params[:listing_id]), notice: "Listing removed from saved."
  end

  private

  def ensure_client!
    redirect_to root_path, alert: "Only clients can save listings." unless current_user.client?
  end
end

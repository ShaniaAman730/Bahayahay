class Admin::ListingsController < ApplicationController

  before_action :require_admin 
  before_action :set_listing, only: [:approve, :reject]

def index
  @pending_listings = Listing.pending_approval
                              .with_attached_listing_photos
                              .order(created_at: :desc)
                              .page(params[:page])
                              .per(10)
end

  def show
    @listing = Listing.find(params[:id])
  end

  def approve
    @listing.update(approved: true)
    redirect_to admin_listings_path, notice: "Listing approved."
  end

  def reject
    @listing.update(approved: false)
    redirect_to admin_listings_path, alert: "Listing rejected."
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

end

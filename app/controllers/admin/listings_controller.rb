class Admin::ListingsController < ApplicationController

  before_action :require_admin 
  before_action :set_listing, only: [:approve, :reject]

  def index
    @pending_listings = Listing.pending_approval
                               .where(for_edit: false)
                               .with_attached_listing_photos
                               .order(created_at: :desc)
                               .page(params[:page])
                               .per(10)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def approve
    @listing = Listing.find(params[:id])
    if @listing.update(approved: true, for_edit: false, rejection_reason: nil)
      redirect_to admin_listings_path, notice: "Listing approved."
    else
      Rails.logger.error("Listing approval failed: #{@listing.errors.full_messages.join(", ")}")
      redirect_to admin_listings_path, alert: "Approval failed: #{@listing.errors.full_messages.join(", ")}"
    end
  end

  def reject
    @listing = Listing.find(params[:id])
    reason = listing_params[:custom_reason].presence || listing_params[:rejection_reason]
    reason ||= "No reason provided"
    if @listing.update(approved: false, for_edit: true, rejection_reason: reason)
      redirect_to admin_listings_path, notice: "Listing rejected with reason: #{reason}"
    else
      Rails.logger.error("Listing rejection failed: #{@listing.errors.full_messages.join(", ")}")
      redirect_to admin_listings_path, alert: "Rejection failed: #{@listing.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to admin_listings_path, alert: "Listing has been deleted."
  end


  private

  def listing_params
    params.require(:listing).permit(:rejection_reason, :custom_reason)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

end


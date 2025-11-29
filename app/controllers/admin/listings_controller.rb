class Admin::ListingsController < ApplicationController

  before_action :require_admin 
  before_action :set_listing, only: [:approve, :reject]

  def index
    @pending_listings = Listing.pending_approval.where(for_edit: false).with_attached_listing_photos.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def approve
    @listing = Listing.find(params[:id])
    if @listing.update(listing_metadata_params.merge(approved: true, for_edit: false, rejection_reason: nil))

      # Purge sensitive files 
      @listing.valid_id.purge if @listing.valid_id.attached?
      @listing.birthcert.purge if @listing.birthcert.attached?
      @listing.tct.purge if @listing.tct.attached?

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

  def metadata_search
    if params[:q].present?
      q = "%#{params[:q].downcase}%"

      @results = Listing.where(
        "LOWER(title) LIKE ? OR CAST(id AS TEXT) LIKE ?", q, q
      )
    end
  end



  private

  def listing_params
    params.require(:listing).permit(:rejection_reason, :custom_reason)
  end

  def listing_metadata_params
    params.require(:listing).permit(:valid_id_last4, :tin_last4, :birthcert_matches_id, :tct_last4, :tct_remarks)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

end


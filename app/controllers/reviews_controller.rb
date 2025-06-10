class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing
  before_action :authorize_review!, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = @listing.build_review(review_params.merge(
      client: current_user,
      realtor: @listing.realtor
    ))

    if @review.save
      redirect_to listing_path(@listing), notice: "Thank you for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def authorize_review!
    unless @listing.confirmed_transaction? && @listing.client == current_user
      redirect_to root_path, alert: "You are not allowed to review this transaction."
    end
  end

  def review_params
    params.require(:review).permit(:comment, :knowledge_rating, :responsiveness_rating,:professionalism_rating)
  end
end

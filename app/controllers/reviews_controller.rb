class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing
  before_action :authorize_review!, only: [:new, :create]
  before_action :set_review, only: [:destroy] 

  def new
    @review = Review.new
  end

  def create
    @review = @listing.build_review(review_params.merge(
      client: current_user,
      realtor: @listing.realtor,
      read: false
    ))

    if @review.save
      # This is for the review feed
      ReviewEvent.create!(
        realtor: @listing.realtor,
        client: current_user,
        listing: @listing,
        review: @review,
        event_type: "review",
        message: "#{current_user.first_name} just left a review for your listing #{@listing.title}."
      )
      redirect_to listing_path(@listing), notice: "Thank you for your review!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to review_events_user_path(current_user), notice: "Your review was deleted successfully."
  end


  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_review
    @review = @listing.review 
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


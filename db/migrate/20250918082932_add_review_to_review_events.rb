class AddReviewToReviewEvents < ActiveRecord::Migration[8.0]
  def change
    add_reference :review_events, :review, foreign_key: true
  end
end

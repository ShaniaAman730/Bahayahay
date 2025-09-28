class AddReadToReviewEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :review_events, :read, :boolean, default: false
  end
end

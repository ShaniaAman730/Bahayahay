class RemoveRatingFromReviews < ActiveRecord::Migration[8.0]
  def change
    remove_column :reviews, :rating, :integer
  end
end

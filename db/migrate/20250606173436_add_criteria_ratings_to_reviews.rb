class AddCriteriaRatingsToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :knowledge_rating, :integer
    add_column :reviews, :responsiveness_rating, :integer
    add_column :reviews, :professionalism_rating, :integer
  end
end

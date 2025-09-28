class AddReadToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :read, :boolean, default: false
  end
end

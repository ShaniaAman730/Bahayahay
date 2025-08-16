class AddApprovalRequestsCountToListings < ActiveRecord::Migration[8.0]
  def change
    add_column :listings, :approval_requests_count, :integer, default: 0, null: false
  end
end

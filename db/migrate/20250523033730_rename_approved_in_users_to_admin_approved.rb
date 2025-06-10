class RenameApprovedInUsersToAdminApproved < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :approved, :admin_approved
  end
end

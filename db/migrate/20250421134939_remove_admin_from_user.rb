class RemoveAdminFromUser < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :admin, :boolean
  end
end

class AddOrderToRebapMembership < ActiveRecord::Migration[8.0]
  def change
    add_column :rebap_memberships, :order, :integer
    add_index :rebap_memberships, :order, unique: true, where: "role IS NOT NULL"
  end
end

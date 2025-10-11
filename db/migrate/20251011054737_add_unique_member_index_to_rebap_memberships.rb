class AddUniqueMemberIndexToRebapMemberships < ActiveRecord::Migration[8.0]
  def change
    add_index :rebap_memberships, :member_id, unique: true
  end
end

class CreateRebapMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :rebap_memberships do |t|
      t.integer :rebap_id
      t.integer :member_id
      t.string :chapter
      t.string :role
      t.integer :year

      t.timestamps
    end
  end
end

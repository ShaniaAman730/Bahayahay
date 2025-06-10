class AddColumnsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :prc_no, :string
    add_column :users, :dhsud_no, :string
  end
end

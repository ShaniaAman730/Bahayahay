class AddColumnsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_no, :string
    add_column :users, :user_type, :integer
    add_column :users, :address, :string
    add_column :users, :company_name, :string
  end
end

class AddGovIdFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :gov_id_type, :string
    add_column :users, :gov_id_last_digits, :string
  end
end

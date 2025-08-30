class AddBrokerFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :is_broker, :boolean, default: false
    add_column :users, :broker_name, :string
    add_column :users, :broker_prc_no, :string
  end
end


class AddEmailSentToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :email_sent, :boolean
  end
end

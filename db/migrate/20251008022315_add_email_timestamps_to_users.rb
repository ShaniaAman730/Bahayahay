class AddEmailTimestampsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :welcome_email_sent_at, :datetime
    add_column :users, :realtor_approval_email_sent_at, :datetime
    add_column :users, :realtor_rejection_email_sent_at, :datetime
  end
end

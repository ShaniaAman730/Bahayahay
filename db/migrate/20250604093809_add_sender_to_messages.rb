class AddSenderToMessages < ActiveRecord::Migration[8.0]
  def change
    add_reference :messages, :sender, foreign_key: { to_table: :users }
  end
end

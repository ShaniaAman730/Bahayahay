class CreatePasswordResetLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :password_reset_logs do |t|
      t.references :admin, null: false, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.string :new_password, null: false
      t.timestamps
    end
  end
end



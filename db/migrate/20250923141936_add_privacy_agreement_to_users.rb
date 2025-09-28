class AddPrivacyAgreementToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :privacy_agreement, :boolean, default: false, null: false
  end
end

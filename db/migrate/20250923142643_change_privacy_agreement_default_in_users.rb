class ChangePrivacyAgreementDefaultInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :privacy_agreement, from: false, to: nil
    change_column_null :users, :privacy_agreement, true
  end
end

class AddPermitFieldsToRealties < ActiveRecord::Migration[8.0]
  def change
    add_column :realties, :permit_type, :string
    add_column :realties, :permit_last_digits, :string
  end
end

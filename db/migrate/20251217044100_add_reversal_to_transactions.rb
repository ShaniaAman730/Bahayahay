class AddReversalToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :reversed_at, :datetime
    add_column :transactions, :reversal_reason, :string
  end
end

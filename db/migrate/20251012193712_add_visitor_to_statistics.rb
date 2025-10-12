class AddVisitorToStatistics < ActiveRecord::Migration[8.0]
  def change
    add_reference :statistics, :visitor, foreign_key: { to_table: :users }
  end
end

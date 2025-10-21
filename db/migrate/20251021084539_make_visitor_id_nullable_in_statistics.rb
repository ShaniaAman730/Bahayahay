class MakeVisitorIdNullableInStatistics < ActiveRecord::Migration[8.0]
  def change
    change_column_null :statistics, :visitor_id, true
    remove_foreign_key :statistics, :users, column: :visitor_id
    add_foreign_key :statistics, :users, column: :visitor_id, on_delete: :nullify
  end
end

class ChangeReferenceInStatistic < ActiveRecord::Migration[8.0]
  def change
    remove_reference :statistics, :user, foreign_key: true, if_exists: true

    unless column_exists?(:statistics, :trackable_type)
      add_reference :statistics, :trackable, polymorphic: true, index: true
    end
  end
end

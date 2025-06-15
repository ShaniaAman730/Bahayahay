class AddDevProjectToModelHouses < ActiveRecord::Migration[8.0]
  def change
    add_reference :model_houses, :dev_project, foreign_key: true
  end
end

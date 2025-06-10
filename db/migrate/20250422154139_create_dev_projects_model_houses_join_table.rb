class CreateDevProjectsModelHousesJoinTable < ActiveRecord::Migration[8.0]
    def change
      create_join_table :dev_projects, :model_houses do |t|
        t.index :dev_project_id
        t.index :model_house_id
    end
  end
end

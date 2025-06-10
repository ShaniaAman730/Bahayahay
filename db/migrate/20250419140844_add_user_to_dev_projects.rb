class AddUserToDevProjects < ActiveRecord::Migration[8.0]
  def change
    add_reference :dev_projects, :user, null: false, foreign_key: true
  end
end

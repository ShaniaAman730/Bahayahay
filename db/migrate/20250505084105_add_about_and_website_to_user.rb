class AddAboutAndWebsiteToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :about, :text
    add_column :users, :website, :string
  end
end

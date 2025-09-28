class AddAboutAndWebsiteToRealty < ActiveRecord::Migration[8.0]
  def change
    add_column :realties, :about, :text
    add_column :realties, :website, :string
  end
end

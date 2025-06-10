class AddColumnsToDevProject < ActiveRecord::Migration[8.0]
  def change
   # Subdivision
    add_column :dev_projects, :guardhouse, :boolean, default: false, null: false
    add_column :dev_projects, :perimeterfence, :boolean, default: false, null: false
    add_column :dev_projects, :clubhouse, :boolean, default: false, null: false
    add_column :dev_projects, :pool, :boolean, default: false, null: false
    add_column :dev_projects, :coveredcourt, :boolean, default: false, null: false
    add_column :dev_projects, :playground, :boolean, default: false, null: false
    add_column :dev_projects, :joggingpath, :boolean, default: false, null: false
    add_column :dev_projects, :mphall, :boolean, default: false, null: false
    add_column :dev_projects, :tenniscourt, :boolean, default: false, null: false
    add_column :dev_projects, :retailstrip, :boolean, default: false, null: false
    add_column :dev_projects, :chapel, :boolean, default: false, null: false
    add_column :dev_projects, :petpark, :boolean, default: false, null: false
    add_column :dev_projects, :sewagefacility, :boolean, default: false, null: false

  # Condominium  
    add_column :dev_projects, :lobbyconcierge, :boolean, default: false, null: false
    add_column :dev_projects, :cctv, :boolean, default: false, null: false
    add_column :dev_projects, :elevators, :boolean, default: false, null: false
    add_column :dev_projects, :gym, :boolean, default: false, null: false
    add_column :dev_projects, :eventhall, :boolean, default: false, null: false
    add_column :dev_projects, :playarea, :boolean, default: false, null: false
    add_column :dev_projects, :roofdeck, :boolean, default: false, null: false
    add_column :dev_projects, :parking, :boolean, default: false, null: false
    add_column :dev_projects, :firealarm, :boolean, default: false, null: false
    add_column :dev_projects, :businesscenter, :boolean, default: false, null: false
    add_column :dev_projects, :loungearea, :boolean, default: false, null: false
    add_column :dev_projects, :spa, :boolean, default: false, null: false
    add_column :dev_projects, :laundrystation, :boolean, default: false, null: false
    add_column :dev_projects, :generator, :boolean, default: false, null: false
    add_column :dev_projects, :fiberready, :boolean, default: false, null: false
    add_column :dev_projects, :parcellockers, :boolean, default: false, null: false
    add_column :dev_projects, :restaurant, :boolean, default: false, null: false

  # Township Development  
    add_column :dev_projects, :mall, :boolean, default: false, null: false
    add_column :dev_projects, :transportterminal, :boolean, default: false, null: false
    add_column :dev_projects, :bikingtrail, :boolean, default: false, null: false
    add_column :dev_projects, :itpark, :boolean, default: false, null: false
    add_column :dev_projects, :clinic, :boolean, default: false, null: false
  end
end

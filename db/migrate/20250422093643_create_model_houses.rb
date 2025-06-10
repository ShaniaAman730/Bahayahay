class CreateModelHouses < ActiveRecord::Migration[8.0]
  def change
    create_table :model_houses do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.boolean :inherit_amenities
      t.integer :furnish_type
      t.boolean :guardhouse, default: false, null: false
      t.boolean :perimeterfence, default: false, null: false
      t.boolean :cctv, default: false, null: false
      t.boolean :clubhouse, default: false, null: false
      t.boolean :pool, default: false, null: false
      t.boolean :coveredcourt, default: false, null: false
      t.boolean :parks, default: false, null: false
      t.boolean :playground, default: false, null: false
      t.boolean :joggingpaths, default: false, null: false
      t.boolean :conveniencestore, default: false, null: false
      t.boolean :watersystem, default: false, null: false
      t.boolean :drainagesystem, default: false, null: false
      t.boolean :undergroundlines, default: false, null: false
      t.boolean :wastemgmt, default: false, null: false
      t.boolean :garden, default: false, null: false
      t.boolean :carport, default: false, null: false
      t.boolean :dirtykitchen, default: false, null: false
      t.boolean :gate, default: false, null: false
      t.boolean :watertank, default: false, null: false
      t.boolean :homecctv, default: false, null: false
      t.boolean :homepool, default: false, null: false
      t.boolean :lanai, default: false, null: false
      t.boolean :landscaping, default: false, null: false
      t.boolean :aircon, default: false, null: false
      t.boolean :provaircon, default: false, null: false
      t.boolean :wardrobes, default: false, null: false
      t.boolean :modkitchen, default: false, null: false
      t.boolean :crfixtures, default: false, null: false
      t.boolean :lightfixtures, default: false, null: false
      t.boolean :firesystem, default: false, null: false
      t.boolean :intercom, default: false, null: false
      t.boolean :internetprov, default: false, null: false
      t.boolean :cableprov, default: false, null: false
      t.boolean :meterperunit, default: false, null: false
      t.boolean :washingmachineprov, default: false, null: false
      t.boolean :waterheaterprov, default: false, null: false
      t.boolean :smarthomeready, default: false, null: false
      t.boolean :balcony, default: false, null: false
      t.boolean :cityview, default: false, null: false
      t.boolean :mountainview, default: false, null: false
      t.boolean :petfriendly, default: false, null: false
      t.boolean :facingeast, default: false, null: false

      t.timestamps
    end
  end
end

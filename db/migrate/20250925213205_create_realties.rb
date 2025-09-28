class CreateRealties < ActiveRecord::Migration[8.0]
  def change
    create_table :realties do |t|
      t.string :name, null: false
      t.string :business_location
      t.string :email
      t.string :phone_number
      t.integer :status, default: 0, null: false
      t.text :rejection_reason
      t.bigint :head_broker_id, null: false

      t.timestamps
    end

    add_index :realties, :head_broker_id
  end
end

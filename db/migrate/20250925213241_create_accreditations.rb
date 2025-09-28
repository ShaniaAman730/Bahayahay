class CreateAccreditations < ActiveRecord::Migration[8.0]
  def change
    create_table :accreditations do |t|
      t.references :realty, null: false, foreign_key: true
      t.bigint :developer_id, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :accreditations, :developer_id
  end
end

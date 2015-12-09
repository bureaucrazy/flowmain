class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :status
      t.string :error
      t.string :ts_data
      t.references :sensor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

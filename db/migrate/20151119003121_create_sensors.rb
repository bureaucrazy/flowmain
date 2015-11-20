class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :name
      t.integer :sensor_type
      t.string :description
      t.integer :warning_threshold
      t.integer :danger_threshold
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

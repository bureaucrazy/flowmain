class CreateScadas < ActiveRecord::Migration
  def change
    create_table :scadas do |t|
      t.integer :value
      t.string :ts_Data
      t.references :sensor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

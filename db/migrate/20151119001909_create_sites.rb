class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.float :long
      t.float :lat
      t.string :description
      t.integer :client_id

      t.timestamps null: false
    end
  end
end

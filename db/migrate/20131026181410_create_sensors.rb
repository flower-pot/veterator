class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.string :name
      t.integer :unit_id

      t.timestamps
    end
  end
end

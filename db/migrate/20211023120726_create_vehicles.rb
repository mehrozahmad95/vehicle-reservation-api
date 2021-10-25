class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_id, unique: true, index: true
      t.string :car_model
      t.string :car_name
      t.string :car_make
      t.string :car_color
      t.references :customer, foriegn_key: true, index: true

      t.timestamps
    end
  end
end

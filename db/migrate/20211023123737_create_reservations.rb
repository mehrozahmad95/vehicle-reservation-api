class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.date :res_date
      t.time :res_from
      t.time :res_to
      t.boolean :fulfilled, default: false

      t.timestamps
    end
  end
end

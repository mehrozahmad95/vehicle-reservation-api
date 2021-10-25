# == Schema Information
#
# Table name: customers
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :string
#
# Indexes
#
#  index_customers_on_customer_id  (customer_id)
#
class Customer < ApplicationRecord
  #-------------------------------------------------------------------------------------------------
  # VALIDATIONS
  #-------------------------------------------------------------------------------------------------
  validates :customer_id, presence: true
  #-------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  #-------------------------------------------------------------------------------------------------
  has_many :vehicles
  has_many :reservations
  #-------------------------------------------------------------------------------------------------
  # INSTANCE METHODS
  #-------------------------------------------------------------------------------------------------
  def associate_vehicles(vehicle_data)
    customer_vehicle = Vehicle.find_or_initialize_by(vehicle_data["vehicle_id"])
    customer_vehicle.assign_attributes({ car_model: vehicle_data["car_model"],
                                         car_name:  vehicle_data["car_name"],
                                         car_make:  vehicle_data["car_make"],
                                         car_color: vehicle_data["car_color"]})
    customer_vehicle.save!
  end
end

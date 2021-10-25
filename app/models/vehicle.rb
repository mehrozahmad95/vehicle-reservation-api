# == Schema Information
#
# Table name: vehicles
#
#  id          :bigint           not null, primary key
#  car_color   :string
#  car_make    :string
#  car_model   :string
#  car_name    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint
#  vehicle_id  :string
#
# Indexes
#
#  index_vehicles_on_customer_id  (customer_id)
#  index_vehicles_on_vehicle_id   (vehicle_id)
#
class Vehicle < ApplicationRecord
  #-------------------------------------------------------------------------------------------------
  # VALIDATIONS
  #-------------------------------------------------------------------------------------------------
  validates :car_name,:car_color, :car_make, :car_model, :vehicle_id, :customer_id, presence: true
  validates :vehicle_id, uniqueness: true
  #-------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  #-------------------------------------------------------------------------------------------------
  has_many :reservations
  belongs_to :customer
end

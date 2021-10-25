# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  fulfilled   :boolean          default(FALSE)
#  res_date    :date
#  res_from    :time
#  res_to      :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  vehicle_id  :bigint           not null
#
# Indexes
#
#  index_reservations_on_customer_id  (customer_id)
#  index_reservations_on_vehicle_id   (vehicle_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (vehicle_id => vehicles.id)
#
class Reservation < ApplicationRecord
  #-------------------------------------------------------------------------------------------------
  # ASSOCIATIONS
  #-------------------------------------------------------------------------------------------------
  belongs_to :customer
  belongs_to :vehicle
  #-------------------------------------------------------------------------------------------------
  # VALIDATIONS
  #-------------------------------------------------------------------------------------------------
  validates :res_date, :res_from, :res_to, presence: true
  validate :valid_reservation_time?
  validate :valid_date?

  private

  def self.set_customer_vehicle_data(data)
    vehicle = data.dig("vehicle")
    customer = Customer.find_or_create_by(customer_id: data.dig("customer","customer_id"))
    customer_vehicle = customer.vehicles.find_or_initialize_by(vehicle_id: vehicle.dig("vehicle_id"))
    customer_vehicle.assign_attributes({
      car_model: vehicle.dig("car_model"),
      car_make:  vehicle.dig("car_make"),
      car_name:  vehicle.dig("car_name"),
      car_color: vehicle.dig("car_color")
    })
    customer_vehicle.save!

    { customer_id: customer.id, vehicle_id: customer_vehicle.id }
  end

  def valid_reservation_time?
    return if [res_to.blank?, res_from.blank?].any?
    errors.add(:reservation, I18n.t("reservation.time_range_error")) if res_to < res_from
  end

  def valid_date?
    return if res_date.blank?
    errors.add(:reservation, I18n.t("reservation.date_range_error")) if res_date < Date.today
  end

end

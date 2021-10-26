class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :res_date, :res_from, :res_to, :fulfilled, :customer, :vehicle
  
  def customer
    {
      customer_id: object.customer.customer_id,
    }
  end

  def vehicle
    customer_vehicle = object.vehicle
    {
      vehicle_id: customer_vehicle.vehicle_id,
      car_model:  customer_vehicle.car_model,
      car_name:   customer_vehicle.car_name,
      car_make:   customer_vehicle.car_make,
      car_color:  customer_vehicle.car_color
    }
  end
end

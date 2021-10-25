class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :res_date, :res_from, :res_to, :fulfilled, :customer, :vehicle
  
  def customer
    {
      customer_id: object.customer.customer_id,
    }
  end

  def vehicle
    {
      vehicle_id: object.vehicle.vehicle_id,
      car_model:  object.vehicle.car_model,
      car_name:   object.vehicle.car_name,
      car_make:   object.vehicle.car_make,
      car_color:  object.vehicle.car_color
    }
  end
end

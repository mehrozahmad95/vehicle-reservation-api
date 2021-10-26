FactoryBot.define do
  factory :vehicle do
    association :customer
    vehicle_id  { "VEHCL_002"}
    car_model   { "2020" }
    car_name    { "Lorem epsum"}
    car_make    { "ABC" }
    car_color   {"black"}
  end
end

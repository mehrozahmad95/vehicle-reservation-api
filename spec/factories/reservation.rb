FactoryBot.define do
  factory :reservation do
    association :customer
    association :vehicle
    res_date { Date.today }
    res_from { Time.now+2.hours }
    res_to   { Time.now+3.hours }
  end
end

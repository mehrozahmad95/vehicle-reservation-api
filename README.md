## Prerequisite

Things you may want to cover:

* Ruby version
  '3.0.0'
* Rails version
  '6.1.4.1'
## Steps to Setup the Project locally
* Clone or unzip the existing project zip file

* Run bundle install

* Update database.yml
  - Add the following details in default (same cred will work for development and test env)
    ```
      username: xxxxxx
      password: xxxxxx
      host: xxxxxx (localhost in case of running project locally)
    ```
* Database creation
  Run the following commands
    ```
      >> rails db:create
      >> rails db:migrate
    ```
## Running Rspec Testsuite for reservation
Run the following command:
  ```
    bundle exec rspec spec/reservation.rb
  ```
------------------------------------
## Assumptions
-----------------------------------
1. There will be 3 entities for Model
  - Customer
  - Vehicle
  - Reservation
  One Customer have many vehicles and one customer have many reservations
2. We will be able to create multiple reservations providing the same Customer and Vehicle
3. Instead of creating seperate APIs for Customer and Vehicle for updation/creation, we are updating the customer and vehicle data from reservation API only by providing customer or vehicle data.

## Curl requests

### 1. Create Reservation

curl --location --request POST 'http://127.0.0.1:3000/api/v1/reservations' \
--header 'Content-Type: application/json' \
--data-raw '{
    "res_date": "25-11-2021",
    "res_from": "16:30",
    "res_to":   "17:00",
    "customer": {
        "customer_id": "AXCAAS"
    },
    "vehicle": {
        "vehicle_id": "LRWAAAS",
        "car_model": "2009",
        "car_make": "Honda",
        "car_color": "grey",
        "car_name": "Civic"
    }
}'

### 2. Get All Reservations
curl --location --request GET 'http://127.0.0.1:3000/api/v1/reservations'

### 3. View/Show Reservation
curl --location --request GET 'http://127.0.0.1:3000/api/v1/reservations/1'

### 4. Update Reservation
curl --location --request PUT 'http://127.0.0.1:3000/api/v1/reservations/1' --header 'Content-Type: application/json' --data-raw '{
    "fulfilled": "true",
    "customer": {
        "customer_id": "Mehroz CH1234"
    },
    "vehicle": {
        "vehicle_id": "VHC12345",
        "car_model": "2009",
        "car_make": "Honda",
        "car_color": "grey",
        "car_name": "Civic"
    }
}'

### 5. Delete Reservation
curl --location --request DELETE 'http://127.0.0.1:3003/api/v1/reservations/1'
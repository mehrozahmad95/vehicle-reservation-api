require "rails_helper"

RSpec.describe 'Reservation API', type: :request do
  # initialize test data 
  let!(:customer) { create(:customer) }
  let!(:vehicle) { Vehicle.create(vehicle_id: "VEHCL_002",
                                  car_model: "2020",
                                  car_name: "Lorem epsum",
                                  car_make: "ABC",
                                  car_color: "black",
                                  customer_id: customer.id) }
  let!(:reservation) { Reservation.create(customer_id: customer.id,
                                          vehicle_id: vehicle.id,
                                          res_date: Date.today,
                                          res_from: Time.now+2.hours,
                                          res_to: Time.now+3.hours) }
  let!(:reservation_id) { reservation.id }

  # Test suite for GET /reservations
  describe 'GET /reservations' do
    before { get '/api/v1/reservations' }

    it 'returns reservations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /reservations/:id
  describe 'GET /reservations/:id' do
    before { get "/api/v1/reservations/#{reservation_id}" }

    context 'when the record exists' do
      it 'returns the reservation' do
        expect(json).not_to be_empty
        expect(json["vehicle"]["vehicle_id"]).to eq(vehicle.vehicle_id)
        expect(json["customer"]["customer_id"]).to eq(customer.customer_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:reservation_id) { 100 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"error\":\"Reservation not found!\"}")
      end
    end
  end

  # Test suite for POST /reservations
  describe 'POST /reservations' do
    # valid payload
    let(:valid_attributes) {{  "res_date": Date.today+1.day,
                                "res_from": Time.now+2.hours,
                                "res_to":   Time.now+3.hours,
                                "customer": {
                                    "customer_id": customer.id
                                },
                                "vehicle": {
                                    "vehicle_id": vehicle.id,
                                    "car_model": "2009",
                                    "car_make": "Honda",
                                    "car_color": "grey",
                                    "car_name": "Civic"
                                }
                            }}

    context 'when the request is valid' do
      before { post '/api/v1/reservations', params: valid_attributes }

      it 'creates a reservation' do
        expect(json["customer"]["customer_id"]).to eq(customer.id.to_s)
        expect(json["vehicle"]["vehicle_id"]).to eq(vehicle.id.to_s)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/reservations', params: { res_date: Date.today+1.day} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /reservations/:id
  describe 'PUT /reservations/:id' do
    let(:valid_attributes) { {  "fulfilled": "true",
                                "customer": {
                                    "customer_id": customer.id
                                },
                                "vehicle": {
                                    "vehicle_id": vehicle.id,
                                    "car_model": "2009",
                                    "car_make": "Honda",
                                    "car_color": "grey",
                                    "car_name": "Civic"
                                }
                            } }

    context 'when the record exists' do
      before { put "/api/v1/reservations/#{reservation_id}", params: valid_attributes }

      it 'updates the record and returns updated response' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for DELETE /reservations/:id
  describe 'DELETE /reservation/:id' do
    before { delete "/api/v1/reservations/#{reservation_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end

end

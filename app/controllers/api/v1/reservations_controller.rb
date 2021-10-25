class Api::V1::ReservationsController < ApplicationController
  before_action :set_customer_data, only: [:create, :update]
  before_action :set_reservation,   only: [:show, :update, :destroy]
  attr_reader :customer_data

  def index
    render json: Reservation.all, each_serializer: ::ReservationSerializer
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save!
      render json: reservation, serializer: ::ReservationSerializer
    end
  rescue Exception => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def show
    render json: @reservation, serializer: ::ReservationSerializer
  end

  def update
    if @reservation.update!(reservation_params)
      render json: @reservation, serializer: ::ReservationSerializer
    end
  end

  def destroy
    if @reservation.destroy
      render json: { message: I18n.t("reservation.delete_data") }
    else
      render json: { error: I18n.t("reservation.delete_error") }
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find_by_id(params[:id])
    render json: { error: I18n.t("reservation.not_found") }, status: 404 unless @reservation
  end

  def set_customer_data
    @customer_data ||= Reservation.set_customer_vehicle_data(params)
  rescue Exception => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def reservation_params
    params.merge!(customer_id: customer_data[:customer_id], vehicle_id: customer_data[:vehicle_id])
    params.permit([:res_date, :res_from, :res_to, :fulfilled, :customer_id, :vehicle_id])    
  end
end

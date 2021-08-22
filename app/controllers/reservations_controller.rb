# frozen_string_literal: true

##
class ReservationsController < ApplicationController
  def index
    reservations = Reservation.order(start_date: :desc).all
    render json: ReservationSerializer.new(reservations)
  end

  def show
    reservation = Reservation.find(params[:id])
    render json: ReservationSerializer.new(reservation)
  end

  def create
    service = ReservationService.new(params.as_json)
    service.process_payload
    reservation = service.build_record
    if reservation.save
      render json: ReservationSerializer.new(reservation), status: :created
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    service = ReservationService.new(params.as_json)
    service.process_payload
    service.update_params['guest'] = reservation.guest
    return if reservation.update(service.update_params)

    render json: reservation.errors, status: :unprocessable_entity
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
  end
end

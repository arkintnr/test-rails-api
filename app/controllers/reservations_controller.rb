# frozen_string_literal: true

##
class ReservationsController < ApplicationController

  def create
    service = ReservationService.new(params.as_json)
    service.process_payload
    guest = service.build_guest_record

    if guest.save
      reservation = service.build_reservation_record
      if reservation.save
        render json: ReservationSerializer.new(reservation), status: :ok
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    else
      render json: guest.errors, status: :unprocessable_entity
    end

  end
end

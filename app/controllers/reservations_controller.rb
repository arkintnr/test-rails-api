# frozen_string_literal: true

##
class ReservationsController < ApplicationController

  # TODO: Transfer to anoher dir
  def_param_group :reservation do
    param :id, String, desc: "Reservation ID", required: true
    param :type, String, desc: "Object Type", required: true
    param :attributes, Hash do
      param :start_date, String, required: true
      param :end_date, String, required: true
      param :currency, String, required: true
      param :payout_price, String, required: true
      param :security_price, String, required: true
      param :total_price, String, required: true
      param :nights, Integer, required: true
      param :guests, Integer, required: true
      param :adults, Integer, required: true
      param :children, Integer, required: true
      param :infants, Integer, required: true
      param :status, String, required: true
      param :created_at, String, required: true
      param :updated_at, String, required: true
    end
    param :relationships, Hash, required: true do
      param :guest, Hash , required: true do
        param :data, Hash , required: true do
          param :id, String, desc: "Guest ID", required: true
          param :type, String, required: true
        end
      end
    end
  end

  def_param_group :list do
    returns code: 200 do
      param :data, Array, of: Hash, required: true do
        param_group :reservation
      end
    end
  end

  def_param_group :show do
    returns code: 200 do
      param :data, Hash, required: true do
        param_group :reservation
      end
    end
    error 404, "Not Found"
  end

  def_param_group :create do
    returns code: 200 do
      param :data, Hash, required: true do
        param_group :reservation
      end
    end
    error 422, "Unprocessable Entity"
  end

  def_param_group :error_response do
    param :errors, Array, of: Hash do
      param :status, String
      param :title, String
      param :detail, String
      param :source, Hash do
        param :pointer, String
      end
    end
  end

  def_param_group :error_404 do
    returns code: 404 do
      param_group :error_response
    end
  end

  def_param_group :error_422 do
    returns code: 422 do
      param_group :error_response
    end
  end

  api :GET, "/reservations", "List Resrvations"
  param_group :list
  def index
    reservations = Reservation.order(start_date: :desc).all
    render json: ReservationSerializer.new(reservations)
  end

  api :GET, "/reservations/:id", "Show Resrvation"
  param_group :show
  param_group :error_404
  def show
    reservation = Reservation.find(params[:id])
    render json: ReservationSerializer.new(reservation)
  end

  api :POST, "/reservations", "Create Resrvation"
  param_group :create
  param_group :error_422
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

  api :PATCH, "/reservations/:id", "Update Resrvation"
  param_group :error_404
  param_group :error_422
  returns code: 204
  def update
    reservation = Reservation.find(params[:id])
    service = ReservationService.new(params.as_json)
    service.process_payload
    service.update_params['guest'] = reservation.guest
    return if reservation.update(service.update_params)

    render json: reservation.errors, status: :unprocessable_entity
  end

  api :DELETE, "/reservations/:id", "Delete Resrvation"
  param_group :error_404
  returns code: 204
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
  end
end

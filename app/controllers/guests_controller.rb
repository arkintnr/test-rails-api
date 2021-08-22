# frozen_string_literal: true

##
class GuestsController < ApplicationController
  
  # TODO: Transfer to anoher dir
  def_param_group :guest do
    param :id, String, required: true
    param :type, String, required: true
    param :attributes, Hash, required: true do
      param :first_name, String, required: true
      param :last_name, String, required: true
      param :phone, Array, of: String, required: true
      param :email, String, required: true
    end
    param :relationships, Hash do
      param :reservations, Hash do
        param :data, Array, of: Hash, required: true do
          param :id, String, desc: "Reservation id", required: true
          param :type, String, required: true
        end
      end
    end
  end

  def_param_group :list_guest do
    returns code: 200 do
      param :data, Array, of: Hash, required: true do
        param_group :guest
      end
    end
  end

  def_param_group :show do
    returns code: 200 do
      param :data, Hash do
        param_group :guest
      end
    end
  end

  def_param_group :create do
    param :guest, Hash, :required => true, :action_aware => true do
      param :first_name, String, desc: "First Name of the guest", required: true
      param :last_name, String, desc: "Last Name of the guest", required: true
      param :phone, Array, of: String, desc: "Guest Phone numbers", required: true
      param :email, String, desc: "Guest Email", required: true
    end
    error 422, "Unprocessable Entity"
    returns code: 201 do
      param :data, Hash do
        param_group :guest
      end
    end
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

  api :GET, "/guests", "List Guests"
  param_group :list_guest
  def index
    guests = Guest.all
    render json: GuestSerializer.new(guests)
  end

  api :GET, "/guests/:id", "Show Guest"
  param_group :show
  param_group :error_404
  error 404, "Not Found"
  def show
    guest = Guest.find(params[:id])
    render json: GuestSerializer.new(guest)
  end

  api :POST, "/guests", "Create Guest"
  param_group :create
  param_group :error_422
  def create
    guest = Guest.new(guest_params)

    if guest.save
      render json: GuestSerializer.new(guest), status: :created
    else
      render json: guest.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, "/guests/:id", "Update Guest"
  param :guest, Hash, :required => true, :action_aware => true do
    param :first_name, String, desc: "First Name of the guest", optional: true, allow_nil: false
    param :last_name, String, desc: "Last Name of the guest", optional: true, allow_nil: false
    param :phone, Array, of: String, desc: "Guest Phone numbers", optional: true, allow_nil: false
    param :email, String, desc: "Guest Email", optional: true, allow_nil: false
  end
  param_group :error_404
  param_group :error_422
  error 404, "Not Found"
  returns code: 204
  def update
    guest = Guest.find(params[:id])

    render json: guest.errors, status: :unprocessable_entity unless guest.update(guest_params)
  end

  api :DELETE, "/guests/:id", "Delete Guest"
  error 404, "Not Found"
  returns code: 204
  def destroy
    guest = Guest.find(params[:id])
    guest.destroy
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email, phone: [])
  end
end

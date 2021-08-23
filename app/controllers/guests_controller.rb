# frozen_string_literal: true

##
class GuestsController < ApplicationController
  def index
    guests = Guest.all
    render json: GuestSerializer.new(guests)
  end

  def show
    guest = Guest.find(params[:id])
    render json: GuestSerializer.new(guest)
  end

  def create
    guest = Guest.new(guest_params)

    if guest.save
      render json: GuestSerializer.new(guest), status: :created
    else
      render json: guest.errors, status: :unprocessable_entity
    end
  end

  def update
    guest = Guest.find(params[:id])

    render json: guest.errors, status: :unprocessable_entity unless guest.update(guest_params)
  end

  def destroy
    guest = Guest.find(params[:id])
    guest.destroy
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email, phone: [])
  end
end

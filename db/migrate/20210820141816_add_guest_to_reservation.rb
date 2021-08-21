# frozen_string_literal: true

class AddGuestToReservation < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :guest, null: false, foreign_key: true
  end
end

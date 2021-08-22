# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :currency, null: false, default: 0
      t.decimal :payout_price, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :security_price, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :total_price, null: false, default: 0.00, precision: 10, scale: 2
      t.integer :nights, null: false, default: 0
      t.integer :guests, null: false
      t.integer :adults, null: false, default: 0
      t.integer :children, null: false, default: 0
      t.integer :infants, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end

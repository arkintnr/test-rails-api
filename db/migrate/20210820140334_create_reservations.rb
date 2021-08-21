# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :currency, null: false, default: 'USD'
      t.decimal :payout_price, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :security_price, null: false, default: 0.00, precision: 10, scale: 2
      t.decimal :total_price, null: false, default: 0.00, precision: 10, scale: 2
      t.integer :nights, null: false, default: 0
      t.integer :guests, null: false, default: 0
      t.integer :adults, null: false, default: 0
      t.integer :children, null: false, default: 0
      t.integer :infants, null: false, default: 0
      t.string :status, null: false, default: ''
      t.timestamps
    end
  end
end

# frozen_string_literal: true

##
class Reservation < ApplicationRecord
  belongs_to :guest

  enum currency: %i[AUD USD PHP]
  enum status: %i[pending accepted cancelled]

  validates_presence_of :guest, :start_date, :end_date,
                        :currency, :payout_price, :security_price,
                        :total_price, :nights, :guests, :adults,
                        :status

  validate :start_date_before_end_date
  validate :number_of_nights
  validate :total_price_computation
  validate :total_number_of_guests

  def start_date_before_end_date
    return unless !(start_date.nil? || end_date.nil?) && (start_date >= end_date)

    errors.add(:end_date, 'iust be greater than start_date')
  end

  def number_of_nights
    return unless !(start_date.nil? || end_date.nil?) && (nights != (end_date - start_date))

    errors.add(:nights, 'invalid number of nights')
  end

  def total_price_computation
    computed_total_price = payout_price + security_price
    return unless total_price != computed_total_price

    errors.add(:total_price, 'invalid total price computation')
  end

  def total_number_of_guests
    total = adults + children + infants
    errors.add(:guests, 'invalid total number of guests') if guests != total
  end
end

# frozen_string_literal: true

class ReservationSerializer
  include JSONAPI::Serializer
  attributes :start_date, :end_date, :currency,
             :payout_price, :security_price, :total_price,
             :nights, :guests, :adults, :children, :infants,
             :status, :created_at, :updated_at
  belongs_to :guest
end

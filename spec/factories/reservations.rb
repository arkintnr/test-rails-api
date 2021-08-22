# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    start_date { '2021-08-01' }
    end_date { '2021-08-02' }
    currency { :AUD }
    payout_price { 3500.00 }
    security_price { 500.00 }
    total_price { 4000.00 }
    nights { 1 }
    guests { 1 }
    adults { 1 }
    status { :accepted }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#validations' do
    before(:each) do
      @guest = create(:guest)
    end

    it 'tests start_date to be less than end_date' do
      reservation = build(:reservation,
                          guest: @guest,
                          start_date: '2021-08-02',
                          end_date: '2021-08-01')
      expect(reservation).not_to be_valid
    end

    it 'tests total number of nights' do
      reservation = build(:reservation,
                          guest: @guest,
                          start_date: '2021-08-01',
                          end_date: '2021-08-03',
                          nights: 4)

      expect(reservation).not_to be_valid
    end

    it 'tests total_price computation' do
      reservation = build(:reservation,
                          guest: @guest,
                          total_price: 1000,
                          security_price: 200,
                          payout_price: 900)

      expect(reservation).not_to be_valid
    end

    it 'tests total number of guests' do
      reservation = build(:reservation,
                          guest: @guest,
                          guests: 4,
                          adults: 2,
                          children: 1,
                          infants: 0)

      expect(reservation).not_to be_valid
    end
  end
end

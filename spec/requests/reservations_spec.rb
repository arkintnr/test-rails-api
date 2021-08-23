# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Security/JSONLoad
RSpec.describe 'Reservations', type: :request do
  describe '#create' do
    context 'when valid payload' do
      it 'returns 200 response payload#1' do
        guest = create :guest
        file = File.open('spec/assets/payload_1.json')
        payload = JSON.load(file)
        payload['guest']['id'] = guest.id

        post '/reservations', params: payload
        expect(response).to have_http_status(:ok)
      end

      it 'returns 200 response on payload#2' do
        guest = create :guest
        file = File.open('spec/assets/payload_2.json')
        payload = JSON.load(file)
        payload['reservation']['guest_id'] = guest.id

        post '/reservations', params: payload
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid payload' do
      it 'returns 422 response' do
        payload = { "nights": 1 }
        post '/reservations', params: payload
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when updating with valid payload data' do
      it 'returns 200 response' do
        guest = create :guest
        reservation = create(:reservation, guest: guest)
        file = File.open('spec/assets/payload_1.json')
        payload = JSON.load(file)
        payload['guest']['id'] = guest.id
        post '/reservations', params: payload
        reservation.reload
        expect(response).to have_http_status(:ok)
        expect(reservation.total_price).to eq(4300)
        expect(reservation.nights).to eq(4)
        expect(reservation.guests).to eq(4)
      end
    end
  end
end
# rubocop:enable Security/JSONLoad

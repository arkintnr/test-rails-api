# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Reservations', type: :request do
  describe '#index' do
    it 'returns a success response' do
      get '/reservations'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a valid JSON' do
      guest = create :guest
      reservation = create(:reservation, guest: guest)
      get '/reservations'
      body = JSON.parse(response.body).deep_symbolize_keys
      data = {
        data: [
          {
            id: reservation.id.to_s,
            type: 'reservation',
            attributes: {
              start_date: reservation.start_date.strftime('%Y-%m-%d'),
              end_date: reservation.end_date.strftime('%Y-%m-%d'),
              currency: reservation.currency,
              payout_price: reservation.payout_price.to_s,
              security_price: reservation.security_price.to_s,
              total_price: reservation.total_price.to_s,
              nights: reservation.nights,
              guests: reservation.guests,
              adults: reservation.adults,
              children: reservation.children,
              infants: reservation.infants,
              status: reservation.status,
              created_at: reservation.created_at.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
              updated_at: reservation.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
            },
            relationships: {
              guest: {
                data: {
                  id: guest.id.to_s,
                  type: 'guest'
                }
              }
            }
          }
        ]
      }
      expect(body).to eq(data)
    end
  end

  describe '#show' do
    it 'returns a success response' do
      guest = create :guest
      reservation = create(:reservation, guest: guest)
      get "/reservations/#{reservation.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 response if record not found' do
      get '/reservations/1'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#create' do
    context 'when valid payload' do
      it 'returns 201 response payload#1' do
        guest = create :guest
        file = File.open('spec/assets/payload_1.json')
        payload = JSON.load(file)
        payload['guest']['id'] = guest.id

        post '/reservations', params: payload
        expect(response).to have_http_status(:created)
      end

      it 'returns 201 response on payload#2' do
        guest = create :guest
        file = File.open('spec/assets/payload_2.json')
        payload = JSON.load(file)
        payload['reservation']['guest_id'] = guest.id

        post '/reservations', params: payload
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '#update' do
    it 'returns 204 response' do
      guest = create :guest
      reservation = create(:reservation, guest: guest)
      file = File.open('spec/assets/payload_1.json')
      payload = JSON.load(file)
      payload['total_price'] = 2500
      payload['payout_price'] = 2000
      payload['security_price'] = 500
      payload['guest']['id'] = guest.id

      patch "/reservations/#{reservation.id}", params: payload

      reservation.reload
      expect(response).to have_http_status(:no_content)
      expect(reservation.total_price).to eq(2500)
      expect(reservation.payout_price).to eq(2000)
      expect(reservation.security_price).to eq(500)
    end
  end

  it 'returns 404 response if record not found' do
    patch '/guests/1'
    expect(response).to have_http_status(:not_found)
  end

  describe '#destroy' do
    it 'returns 204 response' do
      guest = create :guest
      reservation = create(:reservation, guest: guest)
      delete "/reservations/#{reservation.id}"
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 404 response if record not found' do
      delete '/reservations/1'
      expect(response).to have_http_status(:not_found)
    end
  end
end
# rubocop:enable Metrics/BlockLength

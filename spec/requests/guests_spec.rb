# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe GuestsController, type: :request do
  describe '#index' do
    it 'returns a success response' do
      get '/guests'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a valid JSON' do
      guest = create :guest
      reservation = create(:reservation, guest: guest)
      get '/guests'
      body = JSON.parse(response.body).deep_symbolize_keys
      data = {
        data: [
          {
            id: guest.id.to_s,
            type: 'guest',
            attributes: {
              first_name: guest.first_name,
              last_name: guest.last_name,
              phone: guest.phone,
              email: guest.email
            },
            relationships: {
              reservations: {
                data: [
                  {
                    id: reservation.id.to_s,
                    type: 'reservation'
                  }
                ]
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
      get "/guests/#{guest.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 response if record not found' do
      get '/guests/1'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#create' do
    context 'when invalid payload' do
      it 'returns 422 response' do
        payload = { "last_name": 'ABC' }
        post '/guests', params: { guest: payload }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when valid payload' do
      it 'returns 201 response' do
        payload = {
          "first_name": 'Jane',
          "last_name": 'Doe',
          "phone": ['09123456789'],
          "email": 'janedoe2@gmail.com'
        }
        post '/guests', params: { guest: payload }
        expect(response).to have_http_status(:created)
      end

      it 'returns 422 response if email taken' do
        guest = create :guest
        payload = {
          "first_name": 'Jane',
          "last_name": 'Doe',
          "phone": ['09123456789'],
          "email": guest.email
        }
        post '/guests', params: { guest: payload }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    it 'returns 204 response' do
      guest = create :guest
      patch "/guests/#{guest.id}", params: { guest: { first_name: 'Newto' } }
      guest.reload
      expect(response).to have_http_status(:no_content)
      expect(guest.first_name).to eq('Newto')
    end

    it 'returns 404 response when record not found' do
      patch '/guests/1', params: { guest: { first_name: 'Newto' } }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns 422 response if email taken' do
      guest_one = create :guest
      guest_two = create :guest
      patch "/guests/#{guest_two.id}", params: { guest: { email: guest_one.email } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#destroy' do
    it 'returns 204 response' do
      guest = create :guest
      delete "/guests/#{guest.id}"
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 404 response when record not found' do
      delete '/guests/1'
      expect(response).to have_http_status(:not_found)
    end
  end
end
# rubocop:enable Metrics/BlockLength

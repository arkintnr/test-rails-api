# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :routing do
  it 'routes to reservations#index' do
    expect(get('/reservations')).to route_to('reservations#index')
  end

  it 'routes to reservations#show' do
    expect(get('/reservations/1')).to route_to('reservations#show', id: '1')
  end

  it 'routes to reservations#create' do
    expect(post('/reservations')).to route_to('reservations#create')
  end

  it 'routes to reservations#update' do
    expect(put('/reservations/1')).to route_to('reservations#update', id: '1')
  end

  it 'routes to reservations#destroy' do
    expect(delete('/reservations/1')).to route_to('reservations#destroy', id: '1')
  end
end

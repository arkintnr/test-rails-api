# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :routing do
  it 'routes to reservations#create' do
    expect(post('/reservations')).to route_to('reservations#create')
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestsController, type: :routing do
  it 'routes to guests#index' do
    expect(get('/guests')).to route_to('guests#index')
  end

  it 'routes to guests#show' do
    expect(get('/guests/1')).to route_to('guests#show', id: '1')
  end

  it 'routes to guests#create' do
    expect(post('/guests')).to route_to('guests#create')
  end

  it 'routes to guests#update' do
    expect(put('/guests/1')).to route_to('guests#update', id: '1')
  end

  it 'routes to guests#destroy' do
    expect(delete('/guests/1')).to route_to('guests#destroy', id: '1')
  end
end

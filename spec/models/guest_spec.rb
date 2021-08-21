# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#validations' do
    before(:each) do
      @guest = create(:guest)
    end

    it 'tests guest object' do
      expect(@guest.email).to eq('johndoe@gmail.com')
    end

    it 'email should be unique' do
      guest = build(:guest, first_name: 'Jay',
                            last_name: 'Doe', email: 'johndoe@gmail.com')
      expect(guest).not_to be_valid
    end
  end
end

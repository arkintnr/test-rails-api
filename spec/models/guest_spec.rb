# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#validations' do
    before(:each) do
      @guest = create(:guest)
    end

    it 'tests first_name presence' do
      guest = build(:guest, first_name: nil)
      expect(guest).not_to be_valid
    end

    it 'tests last_name presence' do
      guest = build(:guest, last_name: nil)
      expect(guest).not_to be_valid
    end

    it 'tests email presence' do
      guest = build(:guest, email: nil)
      expect(guest).not_to be_valid
    end

    it 'email should be unique' do
      guest = build(:guest, first_name: 'Jay',
                            last_name: 'Doe', email: @guest.email)
      expect(guest).not_to be_valid
    end
  end
end

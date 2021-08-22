# frozen_string_literal: true

class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates_presence_of :first_name, :last_name
  validates :email, presence: true, uniqueness: true
end

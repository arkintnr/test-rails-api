# frozen_string_literal: true

class GuestSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :phone, :email
  has_many :reservations
end

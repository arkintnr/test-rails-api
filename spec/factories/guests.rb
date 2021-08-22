# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { [Faker::PhoneNumber.phone_number] }
    email { Faker::Internet.email }
  end
end

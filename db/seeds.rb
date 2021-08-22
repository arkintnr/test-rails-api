# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Guest.find_or_create_by(
  first_name: 'Juan',
  last_name: 'Dela Cruz',
  phone: ['09111234567'],
  email: 'juan.delacruz@gmail.com'
)

Reservation.find_or_create_by(
  guest: Guest.first,
  start_date: '2021-08-01',
  end_date: '2021-08-02',
  currency: :AUD,
  payout_price: 3500.00,
  security_price: 500.00,
  total_price: 4000.00,
  nights: 1,
  guests: 1,
  adults: 1,
  status: :accepted
)

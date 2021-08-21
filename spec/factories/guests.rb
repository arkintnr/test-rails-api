# frozen_string_literal: true

FactoryBot.define do
  factory :guest do
    first_name { 'John' }
    last_name { 'Doe' }
    phone { %w[09121234567 09111231234] }
    email { 'johndoe@gmail.com' }
  end
end

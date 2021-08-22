# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  resources :guests
  resources :reservations
end

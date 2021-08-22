# frozen_string_literal: true

Rails.application.routes.draw do
  resources :guests
  resources :reservations
end

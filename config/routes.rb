# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reservations, only: [:create]
end

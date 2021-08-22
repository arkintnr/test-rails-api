# frozen_string_literal: true

##
class ApplicationController < ActionController::API
  include JsonapiErrorsHandler
  ErrorMapper.map_errors!(
    {
      'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound',
      'ActiveRecord::RecordInvalid' => 'JsonapiErrorsHandler::Errors::Invalid'
    }
  )
  rescue_from ::StandardError, with: ->(e) { handle_error(e) }
end

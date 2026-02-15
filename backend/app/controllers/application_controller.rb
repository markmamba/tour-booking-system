class ApplicationController < ActionController::API
  rescue_from Errors::BaseError, with: :handle_application_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  rescue_from StandardError, with: :handle_standard_error

  private

  def handle_application_error(error)
    render json: error.to_hash, status: error.http_status
  end

  def handle_not_found(error)
    not_found_error = Errors::NotFoundError.new(resource: error.model)
    render json: not_found_error.to_hash, status: not_found_error.http_status
  end

  def handle_parameter_missing(error)
    validation_error = Errors::ValidationError.new(
      error.param => ["is required"]
    )
    render json: validation_error.to_hash, status: validation_error.http_status
  end

  def handle_standard_error(error)
    Rails.logger.error "Unhandled error: #{error.class} - #{error.message}"
    Rails.logger.error error.backtrace.join("\n")

    internal_error = Errors::InternalServerError.new
    render json: internal_error.to_hash, status: internal_error.http_status
  end
end

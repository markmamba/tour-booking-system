module Api
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    end

    private

    def not_found(exception)
      render_error(exception.message, :not_found, "not_found")
    end

    def unprocessable_entity(exception)
      render_error("Validation failed", :unprocessable_entity, "validation_error", exception.record.errors.full_messages)
    end

    def render_error(message, status, type, details = nil)
      response = {
        error: { type: type, message: message }
      }
      response[:error][:details] = details if details.present?
      render json: response, status: status
    end
  end
end

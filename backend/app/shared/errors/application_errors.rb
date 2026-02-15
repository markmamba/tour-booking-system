module Errors
  class ValidationError < BaseError

    def initialize(errors)
      super(
        message: "Validation failed",
        details: errors,
        status_code: :unprocessable_entity
      )
    end
  end

  class AuthenticationError < BaseError

    def initialize(message: "Authentication failed")
      super(
        message: message,
        status_code: :unauthorized
      )
    end
  end

  class AuthorizationError < BaseError

    def initialize(message: "Access denied")
      super(
        message: message,
        status_code: :forbidden
      )
    end
  end

  class NotFoundError < BaseError

    def initialize(resource: "Resource")
      super(
        message: "#{resource} not found",
        status_code: :not_found
      )
    end
  end

  class ConflictError < BaseError

    def initialize(message: "Resource conflict")
      super(
        message: message,
        status_code: :conflict
      )
    end
  end

  class RateLimitError < BaseError

    def initialize(message: "Rate limit exceeded", retry_after: nil)
      details = {}
      details[:retry_after] = retry_after if retry_after

      super(
        message: message,
        details: details,
        status_code: :too_many_requests
      )
    end
  end

  class InternalServerError < BaseError

    def initialize(message: "Internal server error")
      super(
        message: message,
        status_code: :internal_server_error
      )
    end
  end
end

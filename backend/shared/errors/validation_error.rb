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
end
# Error Handling Documentation

## Overview

This document describes the comprehensive error handling system for the Tour Booking API. The system provides consistent, informative error responses across all endpoints.

## Architecture

### Base Error Class (`Errors::BaseError`)

The foundation of our error handling system is the `BaseError` class, which provides:

- **Consistent error structure**: All errors follow the same response format
- **HTTP status mapping**: Uses `Rack::Utils::SYMBOL_TO_STATUS_CODE` for proper status codes
- **Error details**: Supports additional context information
- **Type identification**: Each error includes its type for client-side handling

```ruby
{
  "error": {
    "type": "validation_error",
    "message": "Validation failed",
    "details": {
      "customer_email": ["is invalid"],
      "number_of_passengers": ["must be greater than 0"]
    }
  }
}
```

### Error Hierarchy

```
Errors::BaseError
├── Errors::ValidationError (422)
├── Errors::AuthenticationError (401)
├── Errors::AuthorizationError (403)
├── Errors::NotFoundError (404)
├── Errors::ConflictError (409)
├── Errors::RateLimitError (429)
└── Errors::InternalServerError (500)
```

## Error Types and Usage

### 1. ValidationError (422 Unprocessable Entity)

Used for business logic validation failures.

```ruby
# In validators
raise Errors::ValidationError.new(validator.errors)

# Custom validation
raise Errors::ValidationError.new(
  "booking_date" => ["cannot be in the past"]
)
```

### 2. AuthenticationError (401 Unauthorized)

Used when authentication fails or is missing.

```ruby
# In BaseController
raise Errors::AuthenticationError.new unless @current_user

# Custom message
raise Errors::AuthenticationError.new("Invalid token")
```

### 3. AuthorizationError (403 Forbidden)

Used when authenticated user lacks permission.

```ruby
# In controllers/services
raise Errors::AuthorizationError.new unless user.admin?

# Custom message
raise Errors::AuthorizationError.new("Cannot access other users' bookings")
```

### 4. NotFoundError (404 Not Found)

Used when resources don't exist.

```ruby
# Default usage
raise Errors::NotFoundError.new

# With specific resource
raise Errors::NotFoundError.new(resource: "Tour")

# Custom message
raise Errors::NotFoundError.new("Booking not found")
```

### 5. ConflictError (409 Conflict)

Used for resource conflicts (duplicate bookings, etc.).

```ruby
# Default usage
raise Errors::ConflictError.new

# Custom message
raise Errors::ConflictError.new("Time slot already booked")
```

### 6. RateLimitError (429 Too Many Requests)

Used for rate limiting with optional retry information.

```ruby
# Basic usage
raise Errors::RateLimitError.new

# With retry information
raise Errors::RateLimitError.new(
  "Too many booking attempts",
  retry_after: 60
)
```

### 7. InternalServerError (500 Internal Server Error)

Used for unexpected system errors.

```ruby
# Basic usage
raise Errors::InternalServerError.new

# Custom message
raise Errors::InternalServerError.new("Payment processing failed")
```

## Controller Integration

### ErrorHandler Concern

All API controllers include the `Api::ErrorHandler` concern, which automatically:

1. **Rescues application errors**: Maps all custom errors to proper HTTP responses
2. **Handles common Rails errors**: `ActiveRecord::RecordNotFound`, `ParameterMissing`
3. **Logs unexpected errors**: Catches and logs `StandardError` as 500 responses
4. **Provides consistent responses**: All errors follow the same JSON structure

### Example Controller

```ruby
module Api
  module V1
    module Tours
      class BookingsController < BaseController
        skip_before_action :authenticate_request, only: [:create]

        def create
          request = Tours::Bookings::CreateRequest.new(params: params)
          booking = Tours::Bookings::CreateManager.execute(request: request)

          render json: booking, status: :created
        end

        def show
          booking = Tours::Booking.find(params[:id])

          # Authorization check
          raise Errors::AuthorizationError.new unless booking.user == current_user

          render json: booking
        end
      end
    end
  end
end
```

## Service Layer Usage

### In Managers

```ruby
module Tours
  module Bookings
    class CreateManager
      def self.execute(request:)
        validator = CreateValidator.new(request: request)

        if validator.invalid?
          raise Errors::ValidationError.new(validator.errors)
        end

        # Check availability
        if booking_conflicts?(request)
          raise Errors::ConflictError.new("Time slot already booked")
        end

        booking = Tours::Booking.new(...)
        booking.save!
        booking
      end
    end
  end
end
```

### In Services

```ruby
module Identities
  module Services
    class TokenManager
      def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
      rescue JWT::DecodeError
        raise Errors::AuthenticationError.new("Invalid token")
      end
    end
  end
end
```

## Client-Side Error Handling

### Error Response Structure

```typescript
interface ErrorResponse {
  error: {
    type: string;
    message: string;
    details: Record<string, string[]>;
  };
}
```

### Example Client Handling

```typescript
const handleApiError = (error: ErrorResponse) => {
  switch (error.error.type) {
    case 'validation_error':
      // Show validation errors next to form fields
      Object.entries(error.error.details).forEach(([field, messages]) => {
        setFieldError(field, messages[0]);
      });
      break;

    case 'authentication_error':
      // Redirect to login
      redirectTo('/login');
      break;

    case 'authorization_error':
      // Show access denied message
      showToast('You do not have permission to perform this action');
      break;

    case 'not_found_error':
      // Show 404 page
      showNotFound();
      break;

    case 'rate_limit_error':
      // Show rate limit message with retry time
      const retryAfter = error.error.details.retry_after;
      showToast(`Rate limited. Try again in ${retryAfter} seconds`);
      break;

    default:
      // Generic error handling
      showToast('Something went wrong. Please try again.');
  }
};
```

## Best Practices

### 1. Use Specific Error Types

```ruby
# Good
raise Errors::ValidationError.new(validator.errors)
raise Errors::NotFoundError.new(resource: "Booking")

# Avoid
raise StandardError.new("Something went wrong")
```

### 2. Provide Context in Details

```ruby
# Good
raise Errors::ValidationError.new({
  "booking_date" => ["cannot be in the past"],
  "number_of_passengers" => ["exceeds tour capacity"]
})

# Minimal
raise Errors::ValidationError.new("Invalid input")
```

### 3. Use Proper HTTP Status Codes

The error system automatically maps to correct HTTP status codes:
- `ValidationError` → 422
- `AuthenticationError` → 401
- `AuthorizationError` → 403
- `NotFoundError` → 404
- `ConflictError` → 409
- `RateLimitError` → 429
- `InternalServerError` → 500

### 4. Log Unexpected Errors

The `ErrorHandler` automatically logs unexpected errors with full stack traces for debugging.

## Testing Error Handling

### RSpec Examples

```ruby
RSpec.describe Api::V1::Tours::BookingsController do
  describe "POST create" do
    context "with invalid data" do
      it "returns validation errors" do
        post :create, params: { booking: { customer_name: "" } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include(
          "error" => {
            "type" => "validation_error",
            "message" => "Validation failed",
            "details" => hash_including("customer_name")
          }
        )
      end
    end

    context "when booking conflicts" do
      it "returns conflict error" do
        allow_any_instance_of(CreateManager)
          .to receive(:execute)
          .and_raise(Errors::ConflictError.new("Time slot booked"))

        post :create, params: { booking: valid_booking_params }

        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)["error"]["type"]).to eq("conflict_error")
      end
    end
  end
end
```

## File Structure

```
shared/
├── errors/
│   ├── base_error.rb              # Base error class
│   ├── validation_error.rb        # Validation errors
│   └── application_errors.rb      # All other error types
└── ...

app/
├── controllers/
│   └── concerns/
│       └── api/
│           └── error_handler.rb  # Controller error handling
└── ...
```

This error handling system ensures consistent, informative, and maintainable error responses across the entire API.
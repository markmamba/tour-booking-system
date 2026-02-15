# API Error Handling Design

All API endpoints return errors in a standardized JSON format. This ensures the frontend can consistently display error messages to the user.

## Standard Error Response

```json
{
  "error": {
    "type": "error_code_string",
    "message": "Human readable message",
    "details": [] // Optional array of specific validation errors
  }
}
```

## Common Error Types

| HTTP Status | Type | Description |
| :--- | :--- | :--- |
| **400 Bad Request** | `bad_request` | The request was malformed. |
| **401 Unauthorized** | `unauthorized` | Authentication token is missing or invalid. |
| **403 Forbidden** | `forbidden` | User is authenticated but not allowed to perform this action. |
| **404 Not Found** | `not_found` | The requested resource (ID) does not exist. |
| **422 Unprocessable** | `validation_error` | The data provided failed validation rules. |
| **500 Internal Error** | `server_error` | Something went wrong on the server. |

## Examples

### 404 Not Found
```json
{
  "error": {
    "type": "not_found",
    "message": "Booking not found"
  }
}
```

### 422 Validation Error
```json
{
  "error": {
    "type": "validation_error",
    "message": "Validation failed",
    "details": ["Email can't be blank", "Pickup datetime must be in the future"]
  }
}
```
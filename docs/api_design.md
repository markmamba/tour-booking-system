# API Design & Contract

## Global Standards
- **Base URL:** `/api/v1`
- **Format:** JSON
- **Auth Header:** `Authorization: Bearer <token>`

---

## Domain: Identity (Auth & Users)

### 1. Driver Login
- **POST** `/auth/login`
- **Request:**
  ```json
  { "email": "driver@example.com", "password": "secret" }
  ```
- **Response (200 OK):**
  ```json
  {
    "token": "eyJhbGciOiJIUz...",
    "user": { "id": 1, "name": "Henson", "email": "driver@example.com" }
  }
  ```

### 2. Get Current User (Me)
- **GET** `/auth/me`
- **Headers:** Requires Token
- **Response:** User details.

---

## Domain: Tours (Bookings)

### 1. Create Booking (Public)
- **POST** `/tours/bookings`
- **Auth:** Public (No token required)
- **Request:**
  ```json
  {
    "booking": {
      "customer_name": "John Doe",
      "customer_email": "john@test.com",
      "service_type": "airport_transfer",
      "pickup_datetime": "2023-12-25T10:00:00Z",
      "pickup_address": "NRT Terminal 1"
    }
  }
  ```

### 2. List Bookings (Driver Dashboard)
- **GET** `/tours/bookings`
- **Auth:** Required (Driver)
- **Query Params:** `?status=pending` (optional)
- **Response:** Array of bookings.

### 3. Update Booking Status (Driver Action)
- **PATCH** `/tours/bookings/:id`
- **Auth:** Required (Driver)
- **Request:**
  ```json
  { "status": "confirmed" }
  ```

---

## Business Logic (Services)
- **PriceCalculator:** Logic to determine `quoted_price` based on `service_type` and `duration/distance`.
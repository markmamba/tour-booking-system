# Project Naming Conventions

## 1. General Language Standards

| Context | Convention | Example |
| :--- | :--- | :--- |
| **Ruby (Backend)** | `snake_case` | `current_user`, `pickup_datetime` |
| **Classes/Modules** | `PascalCase` | `PriceCalculator`, `Identity::User` |
| **TypeScript (Frontend)** | `camelCase` | `currentUser`, `pickupDatetime` |
| **React Components** | `PascalCase` | `BookingForm`, `DriverDashboard` |
| **Database Tables** | `snake_case` (Plural) | `identities_users`, `tours_bookings` |

---

## 2. Domain-Driven Design (Backend)

We organize code by **Bounded Contexts** (Domains).

### Models
- **Namespace:** `DomainName::ModelName`
- **File Path:** `app/domains/domain_name/model_name.rb`
- **Table Name:** `domain_plural_model_plural`
- **Example:**
  - Class: `Tours::Booking`
  - File: `app/domains/tours/booking.rb`
  - Table: `tours_bookings`

### Controllers (API)
- **Namespace:** `Api::V1::DomainName::ResourcePluralController`
- **Path:** `app/controllers/api/v1/tours/bookings_controller.rb`
- **Route:** `/api/v1/tours/bookings`

### Service Objects
- **Naming:** `VerbNoun` (Action-based)
- **Path:** `app/domains/domain_name/services/verb_noun.rb`
- **Example:** `Tours::Services::CalculateQuote`

---

## 3. API Contract (The "Case Gap")

To keep the MVP simple and avoid complex serialization layers, we will follow the **Backend's Native Format** in the JSON.

- **JSON Keys:** `snake_case` (Matches Rails DB columns)
- **Frontend Handling:** The Frontend types must match this.

**Example JSON Response:**
```json
{
  "customer_name": "John Doe",  // NOT customerName
  "pickup_address": "Tokyo"     // NOT pickupAddress
}
```
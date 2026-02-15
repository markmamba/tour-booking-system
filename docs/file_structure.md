# Project File Structure

This document provides an overview of the monorepo's file structure, following Domain-Driven Design (DDD) principles.

## 1. Root Directory

The project root is organized into three main areas:

-   `/backend`: The Rails API application.
-   `/frontend`: The React + TypeScript client application.
-   `/docs`: All project documentation, including API design, database schema, and architectural decisions.

```text
/tour-booking-system
├── backend/
├── frontend/
└── docs/
```

## 2. Backend (`/backend`)

The Rails backend is structured to separate concerns by business domain.

```text
backend/
├── app/
│   ├── controllers/
│   │   └── api/
│   │       └── v1/
│   │           ├── identities/
│   │           └── tours/
│   └── domains/
│       ├── identities/
│       │   ├── services/
│       │   └── user.rb
│       └── tours/
│           ├── services/
│           └── booking.rb
├── config/
├── db/
└── spec/
```

-   **`app/domains/`**: This is the heart of our DDD architecture. Each subdirectory represents a **Bounded Context**.
    -   **`identity/`**: Handles user authentication, profiles, and permissions.
    -   **`tours/`**: Handles the core business logic of creating and managing bookings.
    -   **`*/services/`**: Contains service objects that encapsulate specific business operations (e.g., `Tours::Services::CalculateQuote`).

-   **`app/controllers/api/v1/`**: All API controllers are versioned and namespaced. They are organized by domain to align with the `domains` directory. These controllers should be "thin," delegating most work to service objects.

-   **`config/`**: Contains application initializers, routes (`routes.rb`), and secrets (`credentials.yml.enc`).

-   **`db/`**: Holds the database schema (`schema.rb`), migrations, and seed data (`seeds.rb`).

-   **`spec/`**: (Once RSpec is installed) Will contain all tests, mirroring the `app` structure.

## 3. Frontend (`/frontend`)

The React frontend is structured by **feature**, which aligns with the backend's domains.

```text
frontend/
└── src/
    ├── api/              # Centralized API client (e.g., using axios)
    ├── features/
    │   ├── identities/
    │   │   ├── components/   # LoginForm, DriverProfile
    │   │   ├── hooks/        # useAuth
    │   │   └── types.ts      # User, AuthResponse
    │   └── tours/
    │       ├── components/   # BookingForm, BookingList
    │       ├── hooks/        # useBookings
    │       └── types.ts      # Booking
    ├── shared/
    │   ├── components/       # Button, Input, Modal
    │   ├── hooks/            # useLocalStorage, useDebounce
    │   └── layouts/          # MainLayout, AdminLayout
    ├── styles/               # Global CSS, Tailwind config
    └── App.tsx
```

-   **`src/features/`**: The core application logic, separated by domain.
    -   **`identity/`**: Components and hooks related to login, logout, and user profiles.
    -   **`tours/`**: Components and hooks for the booking form, booking list, etc.

-   **`src/shared/`**: Reusable code that is not specific to any single feature.
    -   **`api/`**: A centralized client for making API calls to the backend.
    -   **`components/`**: Generic, reusable UI components like `Button`, `Input`, `Modal`.
# System Design (MVP)

## Architecture Overview

The system follows a standard Client-Server architecture using a RESTful API.

- **Frontend (Client)**: Single Page Application (SPA) using React + TypeScript.
  - **Public Portal**: Booking form for tourists.
  - **Driver Dashboard**: Admin panel for managing schedule and requests.
- **Backend (Server)**: Ruby on Rails (API Mode).
- **Database**: PostgreSQL.

## Database Schema (Core Models)

### Users (Drivers)
- Authentication details (Email, Password).
- Profile (Name, Vehicle details).

### Bookings
- **Customer Info**: Name, Contact (Line/WhatsApp).
- **Type**: `airport_transfer` vs `hourly_tour`.
- **Logistics**: Pickup time, Location, Flight Number (if airport), Duration (if tour).
- **Status**: `pending`, `confirmed`, `cancelled`.

## Key API Endpoints

- `POST /api/bookings`: Submit a new booking (Public).
- `POST /api/login`: Driver authentication.
- `GET /api/admin/bookings`: View schedule (Protected).
- `PATCH /api/admin/bookings/:id`: Update status (Protected).

## Visual Architecture

Below is a Mermaid diagram representing the system flow. You can view this in VS Code or paste the code into Draw.io.

```mermaid
graph TD
    %% Actors
    Tourist((Tourist))
    Driver((Driver))

    %% Frontend Layer
    subgraph "Frontend (React + TypeScript)"
        PublicPortal[Public Booking Page]
        DriverDash[Driver Dashboard]
    end

    %% Backend Layer
    subgraph "Backend (Ruby on Rails API)"
        API[API Endpoints]
    end

    %% Database Layer
    DB[(PostgreSQL)]

    %% Data Flow
    Tourist -->|1. Submits Request| PublicPortal
    Driver -->|2. Manages Schedule| DriverDash

    PublicPortal -->|3. POST JSON| API
    DriverDash -->|4. GET/PATCH JSON| API

    API -->|5. Read/Write| DB
```
# Japan Tour Booking System

A booking management system for professional drivers in Japan, featuring a public booking portal and a driver dashboard.

## Project Structure

This project is set up as a **Monorepo** containing two distinct applications:

### 1. Backend (`/backend`)
- **Framework**: Ruby on Rails 8 (API Mode)
- **Database**: PostgreSQL
- **Responsibility**: Handles data persistence, authentication, and business logic (pricing, emails).
- **Port**: `3000`

### 2. Frontend (`/frontend`)
- **Framework**: React + TypeScript (Vite)
- **Styling**: Tailwind CSS
- **Responsibility**: User interface for Tourists (Booking Form) and Drivers (Admin Dashboard).
- **Port**: `5173` (default Vite port)

## Quick Start

You will need two terminal tabs to run the development environment.

**Terminal 1 (Backend):**
```bash
cd backend
bundle install
rails s
```

**Terminal 2 (Frontend):**
```bash
cd frontend
npm install
npm run dev
```
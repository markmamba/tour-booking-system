# Tour Booking System

This is a monorepo for a tour and airport transfer booking system, featuring a Rails API backend and a React/TypeScript frontend.

## Prerequisites

Before you begin, ensure you have the following installed:

- **Ruby:** Version specified in `backend/.ruby-version`
- **Node.js:** LTS version (e.g., v20.x)
- **PostgreSQL:** A running instance for the database.
- **Bundler:** `gem install bundler`
- **Yarn** or **npm:** `npm install -g yarn`

---

## 🚀 Getting Started

Follow these steps to get your development environment set up.

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd tour-booking-system
```

### 2. Backend Setup (Rails API)

```bash
# Navigate to the backend directory
cd backend

# Install Ruby dependencies
bundle install

# Setup Rails credentials
# This will open your default editor. Add a secret for 'jwt_secret_key'.
EDITOR="code --wait" rails credentials:edit

# Create and migrate the database
rails db:create
rails db:migrate

# Seed the database with initial data
rails db:seed
```

### 3. Frontend Setup (React App)

```bash
# In a new terminal, navigate to the frontend directory
cd frontend

# Install Node.js dependencies
npm install
```

### 4. Running the Application

- **Start the Rails server:** In the `backend` directory, run:
  ```bash
  rails s
  ```
  *(API will be available at `http://localhost:3000`)*

- **Start the React dev server:** In the `frontend` directory, run:
  ```bash
  npm run dev
  ```
  *(App will be available at `http://localhost:5173`)*
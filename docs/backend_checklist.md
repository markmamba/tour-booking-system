# Backend Development Checklist

This document outlines key considerations and best practices for building the Rails backend, ensuring it is secure, maintainable, and scalable.

- [ ] **Understand the Architecture:** Review the `docs/file_structure.md` to understand the Domain-Driven Design layout.

## 1. Environment & Configuration

- [ ] **Manage Ruby Version:** Create a `.ruby-version` file in the `backend` directory to lock the Ruby version for all developers.
- [ ] **Manage Secrets:** Use **Rails Credentials** to store sensitive data encrypted.
  - Run `EDITOR="code --wait" rails credentials:edit` to add secrets.
  - Add `jwt_secret_key` to the credentials file.
  - Ensure `config/master.key` is in `.gitignore` (Rails does this by default).

## 2. Code Quality & Testing

- [ ] **Enforce Style Guide:** Regularly run `bundle exec rubocop` to maintain consistent code style.
- [ ] **Follow Naming Conventions:** Refer to `docs/naming_conventions.md` for DDD and API naming rules.
- [ ] **Setup Testing Framework:** Install and configure `rspec-rails`.
  - **Unit Tests:** For models and service objects (e.g., `PriceCalculator`).
  - **Request Tests:** To validate API endpoints against the `api_design.md` contract.
- [ ] **Use Service Objects:** For all non-trivial business logic. Place them within their domain (e.g., `app/domains/tours/services/price_calculator.rb`).

## 3. Security

- [ ] **Secure API Endpoints:** Create a base API controller that handles JWT authentication and provides a `current_user` object.
- [ ] **Run Security Audits:** Periodically run `bundle exec brakeman` and `bundle exec bundler-audit` to check for vulnerabilities.
- [ ] **Use Strong Parameters:** Never trust user input. Whitelist all parameters in controllers.

## 4. API Implementation

- [ ] **Versioning:** Structure all controllers under a versioned module (e.g., `Api::V1`).
- [ ] **JSON Serialization:** Decide on a serialization strategy to format JSON output consistently (e.g., using a gem like `jsonapi-serializer` or custom presenters).
- [ ] **Centralized Error Handling:** Use `rescue_from` in a base API controller to catch common errors (`ActiveRecord::RecordNotFound`, `ActiveRecord::RecordInvalid`) and return standardized JSON error responses.
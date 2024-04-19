# employee_salary_management

# Employee Management System

This is a Ruby on Rails application for managing employee details and calculating tax deductions for the current financial year.

## Setup

### Prerequisites
- Ruby (version X.X.X)
- Rails (version X.X.X)
- PostgreSQL

### Installation
1. Clone this repository to your local machine.
2. Navigate to the project directory.
3. Run `bundle install` to install dependencies.
4. Set up your PostgreSQL database configuration in `config/database.yml`.
5. Run `rails db:create` to create the development and test databases.
6. Run `rails db:migrate` to run migrations and set up the database schema.

### Starting the Server
Run `rails server` to start the Rails server. By default, the server will start at `http://localhost:3000`.

## Usage

### API Endpoints

#### Store Employee Details
- **Endpoint:** `POST /employees`
- **Request Body:**
  ```json
  {
    "employee": {
      "employee_id": "EMP001",
      "first_name": "John",
      "last_name": "Doe",
      "email": "john.doe@example.com",
      "phone_numbers": "1234567890,9876543210",
      "doj": "2024-04-19",
      "salary": 50000
    }
  }


ApI collection Url
https://api.postman.com/collections/34397148-e6eaa36b-f5f0-4e27-9ab9-ca7bb1293a55?access_key=PMAT-01HVV4HV4MCMRCDFGDED4C5THY

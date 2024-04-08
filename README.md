# README

# Features App

This is a Ruby on Rails application developed to handle earthquake features obtained from USGS (United States Geological Survey) and provide APIs for accessing and managing earthquake data.

## Requirements

- Ruby 3.0.3
- Rails 7.1.3

## Architecture

The application follows a Domain-Driven Design (DDD) architecture, which helps in organizing the codebase based on business domains. It utilizes service objects for handling business logic, repositories for database access, and dependency injection to manage dependencies between different components.

## Usage

To run the task for fetching sismological data from USGS, use the following command:

```rake sismological_data:fetch```

This task fetches earthquake data from the USGS API and persists it into the database using batch insertion.

## Dependencies

The application relies on external dependencies such as:

- HTTParty gem for making HTTP requests to the USGS API.
- Factory Bot Rails and Faker for generating test data in the test environment.

## Getting Started

Follow these steps to set up the application:

1. Clone the repository.
2. Install Ruby 3.0.3 and Rails 7.1.3.
3. Install dependencies using `bundle install`.
4. Set up the database with `rails db:create` and `rails db:migrate`.
5. Run the task for fetching sismological data using `rake sismological_data:fetch`.
6. Start the Rails server with `rails server`.

## API Endpoints

The application exposes the following API endpoints:

- `GET /api/features`: Retrieves a list of earthquake features.
- `POST /api/features/:feature_id/comments`: Creates a comment associated with a specific earthquake feature.

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvements, feel free to open an issue or submit a pull request.
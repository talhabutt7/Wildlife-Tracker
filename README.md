# Wildlife Conservation Locations Manager 🌍🦒

A geospatial web application for managing and discovering wildlife conservation sites, featuring real-time map integration and location-based search capabilities.

![App Screenshot](/public/screenshot.png) <!-- Add actual screenshot path -->

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Configuration](#configuration)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## Features ✨

### Core Functionalities
- **Location Search & Filtering**
    - Geocoded address search with radius filtering (km)
    - Real-time map updates with Leaflet.js
    - Automatic UK-wide fallback view

- **Conservation Site Management**
    - CRUD operations for wildlife locations
    - Coordinate validation for geographic points
    - Responsive list/map dual interface

- **Real-Time Updates**
    - Turbo Streams for instant DOM updates
    - Dynamic map marker integration
    - Form state preservation & auto-reset

- **Data Visualization**
    - Interactive Leaflet.js map layer
    - Automatic center positioning
    - Dynamic marker clustering

### Advanced Features
- Dual interface synchronization (map/list)
- Flash message system with styling
- Form validation with error highlighting
- Responsive mobile-first design
- Search history preservation

## Tech Stack 💻

### Backend
| Component              | Technology               |
|------------------------|--------------------------|
| Framework              | Ruby on Rails 7          |
| Database               | PostgreSQL               |
| Geocoding              | Geocoder gem             |
| Testing                | RSpec, Capybara          |
| API Integration        | OpenStreetMap/Nominatim  |

### Frontend
| Component              | Technology         |
|------------------------|--------------------|
| Core                   | HTML5, CSS3        |
| Dynamic UI             | Hotwire (Turbo)    |
| Mapping                | Leaflet.js         |
| Styling                | Sass               |
| Form Handling          | Rails Form Helpers |

## Installation ⚙️

### Prerequisites
- Ruby 3.2.2+
- PostgreSQL 14+
- Node.js 18+
- Bundler 2.4+

### Setup Steps
1. Clone repository:
   ```bash
   git clone https://github.com/yourusername/Wildlife-Tracker.git
   cd Wildlife-Tracker

2. Install Dependencies:
   ```bash
   bundle install


3. Database Configuration:
   ```bash
    # Create and migrate databases
    rails db:create
    rails db:migrate

4. Start development server:
   ```bash
    rails server

### Testing 🧪

# Full test suite
    ```bash
    bundle exec rspec

# Specific test types
    ```bash
    bundle exec rspec spec/models      # Model specs
    bundle exec rspec spec/controllers # Controller specs
    bundle exec rspec spec/system      # System tests
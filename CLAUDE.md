# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code
in this repository.

## Project Overview

**いちたす (Ichitasu)** is a Ruby on Rails 7 application that helps users track
one task per day. The core philosophy is to value "the intention to act" over
"completing the action" - designed for people who struggle with motivation and
traditional productivity apps.

## Development Commands

### Rails Commands
- `rails server` - Start the development server
- `rails console` - Start Rails console
- `rails db:migrate` - Run database migrations
- `rails db:seed` - Seed the database
- `rails test` - Run all tests
- `rails test test/models/task_test.rb` - Run specific test file

### Asset Building
- `npm run build` - Build JavaScript assets with esbuild
- `npm run build:css` - Build CSS with Tailwind CLI
- `rails assets:precompile` - Precompile assets for production

### Code Quality
- `rubocop` - Run Ruby linter (rubocop-rails-omakase)
- `brakeman` - Run security scanner

## Architecture

### Core Models
- **User**: Authenticated via Devise with unique name validation (max 10 chars)
- **Task**: Belongs to user, one per day per user
  (validated by target_date uniqueness)
  - Title: max 20 characters
  - Description: max 80 characters
  - Target date: required and unique per user

### Key Business Rules
- Users can only register ONE task per day
  (enforced by target_date uniqueness)
- Tasks cannot be edited once created (aligns with app philosophy)
- Focus on "intention to act" rather than completion

### Authentication
- Uses Devise with custom controllers:
  - `users/registrations_controller.rb`
  - `users/sessions_controller.rb`
- Custom routes for user management at `/mypage`

### Frontend Stack
- **Stimulus**: JavaScript framework for interactions
- **Turbo**: SPA-like navigation
- **Tailwind CSS + daisyUI**: Styling framework
- **esbuild**: JavaScript bundling

### Key Routes
- Root: `static_pages#top`
- Tasks: `index`, `new`, `create`, `show` + `complete` action
- User mypage: `users#show`
- Devise authentication paths

## Testing

- Uses default Rails testing framework (not RSpec)
- System tests with Capybara and Selenium WebDriver
- Test files follow Rails conventions in `/test` directory

## Database

- PostgreSQL in production
- SQLite3 likely in development (standard Rails setup)
- Key migrations handle user/task relationships and constraints

## Deployment

- Configured for Render.com
- Uses Puma web server
- Docker support available (Dockerfile, Dockerfile.dev)

## Development Notes

- Japanese language support (locale files in `config/locales/`)
- PWA capabilities (service worker, manifest)
- OGP integration with meta-tags gem for social sharing
- Responsive design focus (recent responsive implementation)
- Mobile-first approach with Tailwind CSS breakpoints
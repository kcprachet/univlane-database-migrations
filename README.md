# UnivLane Database Migrations

This repository contains the shared database migrations for the UnivLane platform.

## Structure

- `prisma/migrations/` - Database migration files
- `prisma/schema.prisma` - Current database schema
- `scripts/` - Utility scripts for migration management
- `docs/` - Documentation

## Usage

This repository is used as a submodule in both:
- `univlane` (customer-facing application)
- `univlane-platform-admin` (platform admin application)

## Adding New Migrations

1. Create your migration in one of the main repositories using Prisma
2. Use the sync script to push the migration to this shared repository
3. Pull the migration in the other repository

## Scripts

- `sync-migrations.js` - Main synchronization script
- `validate-migrations.js` - Validation script

## Important Notes

- Always test migrations in a development environment first
- Ensure backward compatibility when possible
- Coordinate schema changes between teams
- Keep this repository in sync with both main repositories

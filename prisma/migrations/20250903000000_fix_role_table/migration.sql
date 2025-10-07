-- Migration: Fix Role table - add missing fields and change ID to UUID
-- This migration adds the required fields for Auth0 role mapping

-- Add missing columns to Role table
ALTER TABLE "Role" ADD COLUMN IF NOT EXISTS "auth0RoleId" TEXT;
ALTER TABLE "Role" ADD COLUMN IF NOT EXISTS "auth0RoleName" TEXT;
ALTER TABLE "Role" ADD COLUMN IF NOT EXISTS "isSystemRole" BOOLEAN DEFAULT false;
ALTER TABLE "Role" ADD COLUMN IF NOT EXISTS "source" TEXT DEFAULT 'auth0';

-- Create unique index on auth0RoleId
CREATE UNIQUE INDEX IF NOT EXISTS "Role_auth0RoleId_key" ON "Role"("auth0RoleId");

-- Note: The ID field change from CUID to UUID requires a more complex migration
-- For now, we'll keep the existing ID field and add the required columns

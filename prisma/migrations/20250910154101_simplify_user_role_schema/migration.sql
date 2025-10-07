/*
  Migration to simplify user-role schema:
  - Remove WorkspaceUser and WorkspaceRole tables
  - Add roleId and workspaceId to users table
  - Update Role table with scope and permissions
  - Migrate existing data to new structure
*/

-- Step 1: Add new columns to Role table
ALTER TABLE "public"."Role" ADD COLUMN "permissions" TEXT[] DEFAULT ARRAY[]::TEXT[];
ALTER TABLE "public"."Role" ADD COLUMN "scope" TEXT NOT NULL DEFAULT 'organization';

-- Step 2: Add new columns to users table (nullable first)
ALTER TABLE "public"."users" ADD COLUMN "roleId" TEXT;
ALTER TABLE "public"."users" ADD COLUMN "workspaceId" TEXT;

-- Step 3: Migrate data from WorkspaceUser to users table
-- For users with workspace roles, update their roleId and workspaceId
UPDATE "public"."users" 
SET 
  "roleId" = (
    SELECT r.id 
    FROM "public"."Role" r 
    WHERE r.name = (
      SELECT wr.name 
      FROM "public"."WorkspaceRole" wr 
      JOIN "public"."WorkspaceUser" wu ON wr.id = wu."roleId" 
      WHERE wu."userId" = "users".id
    )
    LIMIT 1
  ),
  "workspaceId" = (
    SELECT wu."workspaceId" 
    FROM "public"."WorkspaceUser" wu 
    WHERE wu."userId" = "users".id
    LIMIT 1
  )
WHERE EXISTS (
  SELECT 1 FROM "public"."WorkspaceUser" wu WHERE wu."userId" = "users".id
);

-- Step 4: For users without workspace roles, assign a default role
-- First, ensure we have a default role
INSERT INTO "public"."Role" (id, name, description, "createdAt", "updatedAt", "auth0RoleId", "auth0RoleName", "isSystemRole", source, scope, permissions)
SELECT 
  gen_random_uuid(),
  'Default User',
  'Default user role for existing users',
  NOW(),
  NOW(),
  'default-user-role',
  'Default User',
  true,
  'system',
  'organization',
  ARRAY[]::TEXT[]
WHERE NOT EXISTS (SELECT 1 FROM "public"."Role" WHERE name = 'Default User');

-- Step 5: Assign default role to users without roles
UPDATE "public"."users" 
SET "roleId" = (SELECT id FROM "public"."Role" WHERE name = 'Default User' LIMIT 1)
WHERE "roleId" IS NULL;

-- Step 6: Make roleId NOT NULL
ALTER TABLE "public"."users" ALTER COLUMN "roleId" SET NOT NULL;

-- Step 7: Update Invite table to reference main Role table
-- First, update existing invites to reference main roles
UPDATE "public"."Invite" 
SET "roleId" = (
  SELECT r.id 
  FROM "public"."Role" r 
  WHERE r.name = (
    SELECT wr.name 
    FROM "public"."WorkspaceRole" wr 
    WHERE wr.id = "Invite"."roleId"
  )
  LIMIT 1
)
WHERE EXISTS (
  SELECT 1 FROM "public"."WorkspaceRole" wr WHERE wr.id = "Invite"."roleId"
);

-- Step 8: Make workspaceId nullable in Invite table
ALTER TABLE "public"."Invite" ALTER COLUMN "workspaceId" DROP NOT NULL;

-- Step 9: Drop foreign key constraints
ALTER TABLE "public"."Invite" DROP CONSTRAINT "Invite_roleId_fkey";
ALTER TABLE "public"."WorkspaceRole" DROP CONSTRAINT "WorkspaceRole_workspaceId_fkey";
ALTER TABLE "public"."WorkspaceUser" DROP CONSTRAINT "WorkspaceUser_roleId_fkey";
ALTER TABLE "public"."WorkspaceUser" DROP CONSTRAINT "WorkspaceUser_userId_fkey";
ALTER TABLE "public"."WorkspaceUser" DROP CONSTRAINT "WorkspaceUser_workspaceId_fkey";

-- Step 10: Drop old role column from users table
ALTER TABLE "public"."users" DROP COLUMN "role";

-- Step 11: Drop old tables
DROP TABLE "public"."WorkspaceRole";
DROP TABLE "public"."WorkspaceUser";

-- Step 12: Create indexes
CREATE INDEX "users_roleId_idx" ON "public"."users"("roleId");
CREATE INDEX "users_workspaceId_idx" ON "public"."users"("workspaceId");

-- Step 13: Add foreign key constraints
ALTER TABLE "public"."users" ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "public"."users" ADD CONSTRAINT "users_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "public"."Workspace"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "public"."Invite" ADD CONSTRAINT "Invite_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;

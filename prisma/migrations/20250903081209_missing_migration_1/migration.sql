/*
  Warnings:

  - You are about to drop the `workspace_settings` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `auth0RoleId` on table `Role` required. This step will fail if there are existing NULL values in that column.
  - Made the column `auth0RoleName` on table `Role` required. This step will fail if there are existing NULL values in that column.
  - Made the column `isSystemRole` on table `Role` required. This step will fail if there are existing NULL values in that column.
  - Made the column `source` on table `Role` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "public"."workspace_settings" DROP CONSTRAINT "workspace_settings_workspaceId_fkey";

-- AlterTable
ALTER TABLE "public"."Role" ALTER COLUMN "auth0RoleId" SET NOT NULL,
ALTER COLUMN "auth0RoleName" SET NOT NULL,
ALTER COLUMN "isSystemRole" SET NOT NULL,
ALTER COLUMN "source" SET NOT NULL;

-- AlterTable
ALTER TABLE "public"."Workspace" ADD COLUMN     "isDefault" BOOLEAN DEFAULT false;

-- AlterTable
ALTER TABLE "public"."analytics" ADD COLUMN     "orgId" TEXT;

-- AlterTable
ALTER TABLE "public"."billing" ADD COLUMN     "orgId" TEXT;

-- DropTable
DROP TABLE "public"."workspace_settings";

-- CreateTable
CREATE TABLE "public"."WorkspaceSettings" (
    "id" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "name" TEXT,
    "description" TEXT,
    "timezone" TEXT DEFAULT 'UTC',
    "language" TEXT DEFAULT 'en',
    "settings" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WorkspaceSettings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "WorkspaceSettings_workspaceId_key" ON "public"."WorkspaceSettings"("workspaceId");

-- CreateIndex
CREATE INDEX "conversations_workspaceId_orgId_idx" ON "public"."conversations"("workspaceId", "orgId");

-- CreateIndex
CREATE INDEX "document_chunks_workspaceId_orgId_idx" ON "public"."document_chunks"("workspaceId", "orgId");

-- CreateIndex
CREATE INDEX "leads_workspaceId_orgId_idx" ON "public"."leads"("workspaceId", "orgId");

-- CreateIndex
CREATE INDEX "refined_answers_workspaceId_orgId_idx" ON "public"."refined_answers"("workspaceId", "orgId");

-- CreateIndex
CREATE INDEX "sources_workspaceId_orgId_idx" ON "public"."sources"("workspaceId", "orgId");

-- AddForeignKey
ALTER TABLE "public"."WorkspaceSettings" ADD CONSTRAINT "WorkspaceSettings_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "public"."Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

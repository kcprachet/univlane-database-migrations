/*
  Warnings:

  - You are about to drop the column `orgId` on the `Invite` table. All the data in the column will be lost.
  - You are about to drop the column `universityName` on the `Invite` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId,workspaceId]` on the table `WorkspaceUser` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `expiresAt` to the `Invite` table without a default value. This is not possible if the table is not empty.
  - Added the required column `invitedBy` to the `Invite` table without a default value. This is not possible if the table is not empty.
  - Added the required column `organizationId` to the `Invite` table without a default value. This is not possible if the table is not empty.
  - Added the required column `roleId` to the `Invite` table without a default value. This is not possible if the table is not empty.
  - Added the required column `workspaceId` to the `Invite` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."Invite" DROP CONSTRAINT "Invite_orgId_fkey";

-- DropIndex
DROP INDEX "public"."Invite_orgId_idx";

-- AlterTable
ALTER TABLE "public"."Invite" DROP COLUMN "orgId",
DROP COLUMN "universityName",
ADD COLUMN     "acceptedBy" TEXT,
ADD COLUMN     "cancelledAt" TIMESTAMP(3),
ADD COLUMN     "cancelledBy" TEXT,
ADD COLUMN     "expiresAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "invitedBy" TEXT NOT NULL,
ADD COLUMN     "message" TEXT,
ADD COLUMN     "organizationId" TEXT NOT NULL,
ADD COLUMN     "resentAt" TIMESTAMP(3),
ADD COLUMN     "resentBy" TEXT,
ADD COLUMN     "roleId" TEXT NOT NULL,
ADD COLUMN     "workspaceId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "public"."WorkspaceRole" ADD COLUMN     "description" TEXT,
ADD COLUMN     "permissions" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "public"."WorkspaceUser" ADD COLUMN     "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE INDEX "Invite_organizationId_idx" ON "public"."Invite"("organizationId");

-- CreateIndex
CREATE INDEX "Invite_workspaceId_idx" ON "public"."Invite"("workspaceId");

-- CreateIndex
CREATE INDEX "Invite_status_idx" ON "public"."Invite"("status");

-- CreateIndex
CREATE UNIQUE INDEX "WorkspaceUser_userId_workspaceId_key" ON "public"."WorkspaceUser"("userId", "workspaceId");

-- AddForeignKey
ALTER TABLE "public"."Invite" ADD CONSTRAINT "Invite_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Invite" ADD CONSTRAINT "Invite_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "public"."Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Invite" ADD CONSTRAINT "Invite_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."WorkspaceRole"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Invite" ADD CONSTRAINT "Invite_invitedBy_fkey" FOREIGN KEY ("invitedBy") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

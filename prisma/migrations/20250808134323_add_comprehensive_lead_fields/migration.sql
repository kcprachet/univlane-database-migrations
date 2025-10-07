/*
  Warnings:

  - The values [closed] on the enum `LeadStatus` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "LeadStatus_new" AS ENUM ('new', 'contacted', 'in_progress', 'qualified', 'submitted', 'closed_won', 'closed_lost');
ALTER TABLE "leads" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "leads" ALTER COLUMN "status" TYPE "LeadStatus_new" USING ("status"::text::"LeadStatus_new");
ALTER TYPE "LeadStatus" RENAME TO "LeadStatus_old";
ALTER TYPE "LeadStatus_new" RENAME TO "LeadStatus";
DROP TYPE "LeadStatus_old";
ALTER TABLE "leads" ALTER COLUMN "status" SET DEFAULT 'new';
COMMIT;

-- DropIndex
DROP INDEX "leads_agentId_idx";

-- DropIndex
DROP INDEX "leads_conversationId_idx";

-- DropIndex
DROP INDEX "leads_createdAt_idx";

-- DropIndex
DROP INDEX "leads_orgId_idx";

-- AlterTable
ALTER TABLE "leads" ADD COLUMN     "assignedAt" TIMESTAMP(3),
ADD COLUMN     "fullName" TEXT,
ADD COLUMN     "intakeTerm" TEXT,
ADD COLUMN     "intakeYear" INTEGER,
ADD COLUMN     "lastActivityAt" TIMESTAMP(3),
ADD COLUMN     "locale" TEXT,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "ownerUserId" TEXT,
ADD COLUMN     "programId" TEXT,
ADD COLUMN     "programName" TEXT,
ADD COLUMN     "tags" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "universityId" TEXT,
ADD COLUMN     "universityName" TEXT;

-- CreateIndex
CREATE INDEX "leads_agentId_createdAt_idx" ON "leads"("agentId", "createdAt" DESC);

-- CreateIndex
CREATE INDEX "leads_email_agentId_idx" ON "leads"("email", "agentId");

-- CreateIndex
CREATE INDEX "leads_ownerUserId_idx" ON "leads"("ownerUserId");

-- CreateIndex
CREATE INDEX "leads_lastActivityAt_idx" ON "leads"("lastActivityAt" DESC);

-- CreateIndex
CREATE INDEX "leads_tags_idx" ON "leads" USING GIN ("tags");

-- AddForeignKey
ALTER TABLE "leads" ADD CONSTRAINT "leads_ownerUserId_fkey" FOREIGN KEY ("ownerUserId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

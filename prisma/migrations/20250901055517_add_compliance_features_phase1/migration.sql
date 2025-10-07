/*
  Warnings:

  - You are about to drop the `performance_metrics` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "public"."anonymous_users" ADD COLUMN     "geolocationEncrypted" JSONB,
ADD COLUMN     "ipAddressEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."audit_logs" ADD COLUMN     "dataAccessDetails" JSONB,
ADD COLUMN     "encryptionStatus" TEXT,
ADD COLUMN     "organizationId" TEXT,
ADD COLUMN     "resourceId" TEXT,
ADD COLUMN     "resourceType" TEXT,
ADD COLUMN     "sessionId" TEXT,
ADD COLUMN     "workspaceId" TEXT;

-- AlterTable
ALTER TABLE "public"."conversations" ADD COLUMN     "sessionMetadataEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."device_fingerprints" ADD COLUMN     "canvasHashEncrypted" JSONB,
ADD COLUMN     "fontListEncrypted" JSONB,
ADD COLUMN     "pluginListEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."embed_user_identities" ADD COLUMN     "identityValueEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."lead_flow_states" ADD COLUMN     "collectedDataEncrypted" JSONB,
ADD COLUMN     "extractedInfoEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."leads" ADD COLUMN     "emailEncrypted" JSONB,
ADD COLUMN     "fullNameEncrypted" JSONB,
ADD COLUMN     "messageEncrypted" JSONB,
ADD COLUMN     "nameEncrypted" JSONB,
ADD COLUMN     "phoneEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."messages" ADD COLUMN     "contentEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."user_sessions" ADD COLUMN     "metadataEncrypted" JSONB;

-- AlterTable
ALTER TABLE "public"."users" ADD COLUMN     "emailEncrypted" JSONB,
ADD COLUMN     "nameEncrypted" JSONB;

-- DropTable
DROP TABLE "public"."performance_metrics";

-- CreateTable
CREATE TABLE "public"."retention_policies" (
    "id" TEXT NOT NULL,
    "tableName" TEXT NOT NULL,
    "fieldName" TEXT NOT NULL,
    "retentionDays" INTEGER NOT NULL,
    "action" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "lastExecuted" TIMESTAMP(3),
    "nextExecution" TIMESTAMP(3),
    "organizationId" TEXT NOT NULL,
    "workspaceId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "retention_policies_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "retention_policies_organizationId_idx" ON "public"."retention_policies"("organizationId");

-- CreateIndex
CREATE INDEX "retention_policies_workspaceId_idx" ON "public"."retention_policies"("workspaceId");

-- CreateIndex
CREATE INDEX "retention_policies_enabled_idx" ON "public"."retention_policies"("enabled");

-- CreateIndex
CREATE INDEX "retention_policies_nextExecution_idx" ON "public"."retention_policies"("nextExecution");

-- CreateIndex
CREATE UNIQUE INDEX "retention_policies_tableName_fieldName_organizationId_key" ON "public"."retention_policies"("tableName", "fieldName", "organizationId");

-- CreateIndex
CREATE INDEX "audit_logs_resourceType_idx" ON "public"."audit_logs"("resourceType");

-- CreateIndex
CREATE INDEX "audit_logs_organizationId_idx" ON "public"."audit_logs"("organizationId");

-- CreateIndex
CREATE INDEX "audit_logs_workspaceId_idx" ON "public"."audit_logs"("workspaceId");

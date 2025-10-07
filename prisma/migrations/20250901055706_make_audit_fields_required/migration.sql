/*
  Warnings:

  - Made the column `organizationId` on table `audit_logs` required. This step will fail if there are existing NULL values in that column.
  - Made the column `resourceType` on table `audit_logs` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "public"."audit_logs" ALTER COLUMN "organizationId" SET NOT NULL,
ALTER COLUMN "resourceType" SET NOT NULL;

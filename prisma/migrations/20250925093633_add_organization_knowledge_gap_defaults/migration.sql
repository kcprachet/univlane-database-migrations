/*
  Warnings:

  - You are about to drop the column `knowledgeGapDefaults` on the `Organization` table. All the data in the column will be lost.

*/
-- AlterEnum
ALTER TYPE "public"."LeadStatus" ADD VALUE 'appointment_scheduled';

-- AlterTable
ALTER TABLE "public"."Organization" DROP COLUMN "knowledgeGapDefaults";

-- CreateTable
CREATE TABLE "public"."organization_knowledge_gap_defaults" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "contentGapThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.6,
    "analysisTemperature" DOUBLE PRECISION NOT NULL DEFAULT 0.1,
    "maxAnalysisTokens" INTEGER NOT NULL DEFAULT 2000,
    "conversationHistoryDays" INTEGER NOT NULL DEFAULT 30,
    "maxRecentConversations" INTEGER NOT NULL DEFAULT 50,
    "maxMessagesPerConversation" INTEGER NOT NULL DEFAULT 100,
    "enableContentGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableComplexityGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableTemporalGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableContextualGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableCapabilityGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableNotifications" BOOLEAN NOT NULL DEFAULT true,
    "notificationThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.8,
    "notificationFrequency" TEXT NOT NULL DEFAULT 'daily',
    "enableDetailedAnalysis" BOOLEAN NOT NULL DEFAULT true,
    "enableContextualAnalysis" BOOLEAN NOT NULL DEFAULT true,
    "enableAdaptiveLearning" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "organization_knowledge_gap_defaults_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "organization_knowledge_gap_defaults_organizationId_key" ON "public"."organization_knowledge_gap_defaults"("organizationId");

-- AddForeignKey
ALTER TABLE "public"."organization_knowledge_gap_defaults" ADD CONSTRAINT "organization_knowledge_gap_defaults_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

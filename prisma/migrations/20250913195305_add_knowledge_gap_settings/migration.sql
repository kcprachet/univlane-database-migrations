-- AlterTable
ALTER TABLE "Organization" ADD COLUMN "knowledgeGapDefaults" JSONB;

-- CreateTable
CREATE TABLE "agent_knowledge_gap_settings" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "contentGapThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.6,
    "complexityGapThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.5,
    "temporalGapThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.5,
    "contextualGapThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.4,
    "customGenericPhrases" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "customUncertaintyPhrases" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "conversationHistoryDays" INTEGER NOT NULL DEFAULT 30,
    "similarityThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.7,
    "maxRecentConversations" INTEGER NOT NULL DEFAULT 50,
    "maxMessagesPerConversation" INTEGER NOT NULL DEFAULT 100,
    "detectionStrategy" TEXT NOT NULL DEFAULT 'standard',
    "enableABTesting" BOOLEAN NOT NULL DEFAULT false,
    "abTestVariant" TEXT,
    "enableContentGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableComplexityGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableTemporalGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableContextualGaps" BOOLEAN NOT NULL DEFAULT true,
    "enableNotifications" BOOLEAN NOT NULL DEFAULT true,
    "notificationThreshold" DOUBLE PRECISION NOT NULL DEFAULT 0.8,
    "notificationFrequency" TEXT NOT NULL DEFAULT 'daily',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agent_knowledge_gap_settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_knowledge_gap_settings_agentId_key" ON "agent_knowledge_gap_settings"("agentId");

-- AddForeignKey
ALTER TABLE "agent_knowledge_gap_settings" ADD CONSTRAINT "agent_knowledge_gap_settings_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

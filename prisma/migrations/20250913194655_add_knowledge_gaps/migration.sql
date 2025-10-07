-- CreateTable
CREATE TABLE "knowledge_gaps" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "messageId" TEXT NOT NULL,
    "gapType" TEXT NOT NULL,
    "confidence" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'open',
    "userQuery" TEXT NOT NULL,
    "agentResponse" TEXT NOT NULL,
    "gapDetails" JSONB,
    "detectedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" TIMESTAMP(3),
    "resolutionNotes" TEXT,
    "orgId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "knowledge_gaps_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "knowledge_gaps_agentId_idx" ON "knowledge_gaps"("agentId");

-- CreateIndex
CREATE INDEX "knowledge_gaps_conversationId_idx" ON "knowledge_gaps"("conversationId");

-- CreateIndex
CREATE INDEX "knowledge_gaps_messageId_idx" ON "knowledge_gaps"("messageId");

-- CreateIndex
CREATE INDEX "knowledge_gaps_gapType_idx" ON "knowledge_gaps"("gapType");

-- CreateIndex
CREATE INDEX "knowledge_gaps_status_idx" ON "knowledge_gaps"("status");

-- CreateIndex
CREATE INDEX "knowledge_gaps_confidence_idx" ON "knowledge_gaps"("confidence");

-- CreateIndex
CREATE INDEX "knowledge_gaps_detectedAt_idx" ON "knowledge_gaps"("detectedAt");

-- CreateIndex
CREATE INDEX "knowledge_gaps_workspaceId_orgId_idx" ON "knowledge_gaps"("workspaceId", "orgId");

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES "messages"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "knowledge_gaps" ADD CONSTRAINT "knowledge_gaps_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

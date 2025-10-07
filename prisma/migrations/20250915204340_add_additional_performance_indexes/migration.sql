-- Add additional performance indexes for better query performance

-- Agent table indexes
CREATE INDEX "agents_orgId_workspaceId_isActive_idx" ON "agents"("orgId", "workspaceId", "isActive");
CREATE INDEX "agents_orgId_deploymentStatus_idx" ON "agents"("orgId", "deploymentStatus");

-- Conversation table indexes
CREATE INDEX "conversations_agentId_orgId_idx" ON "conversations"("agentId", "orgId");
CREATE INDEX "conversations_agentId_status_idx" ON "conversations"("agentId", "status");
CREATE INDEX "conversations_orgId_status_idx" ON "conversations"("orgId", "status");
CREATE INDEX "conversations_updatedAt_idx" ON "conversations"("updatedAt");
CREATE INDEX "conversations_createdAt_idx" ON "conversations"("createdAt");

-- Message table indexes
CREATE INDEX "messages_conversationId_idx" ON "messages"("conversationId");
CREATE INDEX "messages_conversationId_createdAt_idx" ON "messages"("conversationId", "createdAt");
CREATE INDEX "messages_sessionId_idx" ON "messages"("sessionId");
CREATE INDEX "messages_sessionId_sessionSequence_idx" ON "messages"("sessionId", "sessionSequence");
CREATE INDEX "messages_createdAt_idx" ON "messages"("createdAt");

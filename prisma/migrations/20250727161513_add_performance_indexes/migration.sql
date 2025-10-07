/*
  Warnings:

  - Made the column `embedding` on table `document_chunks` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Organization" ALTER COLUMN "defaultLlmModel" SET DEFAULT 'gemini-2.0-flash-exp';

-- AlterTable
ALTER TABLE "agents" ALTER COLUMN "model" SET DEFAULT 'gemini-2.0-flash-exp';

-- AlterTable
ALTER TABLE "document_chunks" ADD COLUMN "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE INDEX "agents_userId_orgId_idx" ON "agents"("userId", "orgId");

-- CreateIndex
CREATE INDEX "agents_orgId_isActive_idx" ON "agents"("orgId", "isActive");

-- CreateIndex
CREATE INDEX "agents_userId_isActive_idx" ON "agents"("userId", "isActive");

-- CreateIndex
CREATE INDEX "document_chunks_agentId_idx" ON "document_chunks"("agentId");

-- CreateIndex
CREATE INDEX "document_chunks_agentId_createdAt_idx" ON "document_chunks"("agentId", "createdAt");

-- CreateIndex
CREATE INDEX "document_chunks_sourceId_chunkIndex_idx" ON "document_chunks"("sourceId", "chunkIndex");

-- CreateIndex
CREATE INDEX "sources_agentId_idx" ON "sources"("agentId");

-- CreateIndex
CREATE INDEX "sources_orgId_idx" ON "sources"("orgId");

-- CreateIndex
CREATE INDEX "sources_agentId_createdAt_idx" ON "sources"("agentId", "createdAt");

-- CreateIndex
CREATE INDEX "users_organizationId_idx" ON "users"("organizationId");

-- CreateIndex
CREATE INDEX "users_auth0Id_idx" ON "users"("auth0Id");

-- CreateIndex
CREATE INDEX "users_email_idx" ON "users"("email");

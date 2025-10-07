-- DropIndex
DROP INDEX "document_chunks_agentId_idx";

-- DropIndex
DROP INDEX "document_chunks_orgId_idx";

-- DropIndex
DROP INDEX "document_chunks_sourceId_idx";

-- DropIndex
DROP INDEX "document_chunks_workspaceId_idx";

-- AlterTable
ALTER TABLE "Organization" ADD COLUMN     "defaultLlmModel" TEXT NOT NULL DEFAULT 'gpt-4o-mini',
ADD COLUMN     "defaultLlmProvider" TEXT NOT NULL DEFAULT 'openai',
ADD COLUMN     "llmConfig" JSONB;

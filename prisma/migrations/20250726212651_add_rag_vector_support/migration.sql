-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- CreateTable
CREATE TABLE "document_chunks" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "embedding" vector(1536),
    "metadata" JSONB,
    "chunkIndex" INTEGER NOT NULL,
    "sourceId" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_chunks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "document_chunks_sourceId_idx" ON "document_chunks"("sourceId");

-- CreateIndex
CREATE INDEX "document_chunks_agentId_idx" ON "document_chunks"("agentId");

-- CreateIndex
CREATE INDEX "document_chunks_orgId_idx" ON "document_chunks"("orgId");

-- CreateIndex
CREATE INDEX "document_chunks_workspaceId_idx" ON "document_chunks"("workspaceId");

-- AddForeignKey
ALTER TABLE "document_chunks" ADD CONSTRAINT "document_chunks_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "sources"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_chunks" ADD CONSTRAINT "document_chunks_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_chunks" ADD CONSTRAINT "document_chunks_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_chunks" ADD CONSTRAINT "document_chunks_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

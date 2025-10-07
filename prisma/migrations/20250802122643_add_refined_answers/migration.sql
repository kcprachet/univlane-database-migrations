-- CreateTable
CREATE TABLE "refined_answers" (
    "id" TEXT NOT NULL,
    "originalMessageId" TEXT NOT NULL,
    "refinedContent" TEXT NOT NULL,
    "embedding" vector,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,

    CONSTRAINT "refined_answers_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "refined_answers_agentId_idx" ON "refined_answers"("agentId");

-- CreateIndex
CREATE INDEX "refined_answers_originalMessageId_idx" ON "refined_answers"("originalMessageId");

-- AddForeignKey
ALTER TABLE "refined_answers" ADD CONSTRAINT "refined_answers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refined_answers" ADD CONSTRAINT "refined_answers_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refined_answers" ADD CONSTRAINT "refined_answers_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refined_answers" ADD CONSTRAINT "refined_answers_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

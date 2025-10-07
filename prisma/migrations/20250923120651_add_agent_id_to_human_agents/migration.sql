-- AlterTable
ALTER TABLE "public"."human_agents" ADD COLUMN     "agentId" TEXT;

-- CreateIndex
CREATE INDEX "human_agents_agentId_idx" ON "public"."human_agents"("agentId");

-- AddForeignKey
ALTER TABLE "public"."human_agents" ADD CONSTRAINT "human_agents_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

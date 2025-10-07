-- AlterTable
ALTER TABLE "leads" ADD COLUMN     "intake" TEXT,
ADD COLUMN     "program" TEXT,
ADD COLUMN     "timing" TEXT,
ADD COLUMN     "university" TEXT;

-- CreateTable
CREATE TABLE "lead_flow_states" (
    "id" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "currentStep" INTEGER NOT NULL DEFAULT 1,
    "extractedInfo" JSONB,
    "isCompleted" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lead_flow_states_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "lead_flow_states_conversationId_key" ON "lead_flow_states"("conversationId");

-- CreateIndex
CREATE INDEX "lead_flow_states_conversationId_idx" ON "lead_flow_states"("conversationId");

-- CreateIndex
CREATE INDEX "lead_flow_states_agentId_idx" ON "lead_flow_states"("agentId");

-- CreateIndex
CREATE INDEX "lead_flow_states_orgId_idx" ON "lead_flow_states"("orgId");

-- AddForeignKey
ALTER TABLE "lead_flow_states" ADD CONSTRAINT "lead_flow_states_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lead_flow_states" ADD CONSTRAINT "lead_flow_states_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lead_flow_states" ADD CONSTRAINT "lead_flow_states_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

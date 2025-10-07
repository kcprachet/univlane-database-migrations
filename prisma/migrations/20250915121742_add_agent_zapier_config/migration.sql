-- CreateTable
CREATE TABLE "public"."AgentZapierConfig" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT false,
    "lastTested" TIMESTAMP(3),
    "testStatus" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AgentZapierConfig_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AgentZapierConfig_agentId_key" ON "public"."AgentZapierConfig"("agentId");

-- CreateIndex
CREATE INDEX "AgentZapierConfig_agentId_idx" ON "public"."AgentZapierConfig"("agentId");

-- CreateIndex
CREATE INDEX "AgentZapierConfig_organizationId_idx" ON "public"."AgentZapierConfig"("organizationId");

-- AddForeignKey
ALTER TABLE "public"."AgentZapierConfig" ADD CONSTRAINT "AgentZapierConfig_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AgentZapierConfig" ADD CONSTRAINT "AgentZapierConfig_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

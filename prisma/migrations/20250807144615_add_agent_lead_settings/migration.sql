-- CreateTable
CREATE TABLE "agent_lead_settings" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "isEnabled" BOOLEAN NOT NULL DEFAULT true,
    "triggerKeywords" TEXT[] DEFAULT ARRAY['apply', 'admission', 'fee', 'eligibility', 'deadline']::TEXT[],
    "showNameField" BOOLEAN NOT NULL DEFAULT true,
    "showPhoneField" BOOLEAN NOT NULL DEFAULT true,
    "showProgramField" BOOLEAN NOT NULL DEFAULT true,
    "introText" TEXT DEFAULT 'We''d love to help you with more detailed information! Could you please share your contact details so we can get back to you with personalized assistance?',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agent_lead_settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_lead_settings_agentId_key" ON "agent_lead_settings"("agentId");

-- AddForeignKey
ALTER TABLE "agent_lead_settings" ADD CONSTRAINT "agent_lead_settings_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

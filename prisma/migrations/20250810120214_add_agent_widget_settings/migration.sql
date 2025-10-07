/*
  Warnings:

  - Made the column `introText` on table `agent_lead_settings` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "agent_lead_settings" ALTER COLUMN "isEnabled" SET DEFAULT false,
ALTER COLUMN "triggerKeywords" SET DEFAULT ARRAY[]::TEXT[],
ALTER COLUMN "showPhoneField" SET DEFAULT false,
ALTER COLUMN "introText" SET NOT NULL,
ALTER COLUMN "introText" SET DEFAULT 'I''d be happy to help you with your application! Let me collect some information to provide you with the best guidance.';

-- CreateTable
CREATE TABLE "agent_widget_settings" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "position" TEXT NOT NULL DEFAULT 'bottom-right',
    "theme" TEXT NOT NULL DEFAULT 'light',
    "primaryColor" TEXT,
    "secondaryColor" TEXT,
    "backgroundColor" TEXT,
    "textColor" TEXT,
    "borderRadius" INTEGER NOT NULL DEFAULT 12,
    "showBranding" BOOLEAN NOT NULL DEFAULT true,
    "customLogo" TEXT,
    "customTitle" TEXT,
    "fontSize" TEXT NOT NULL DEFAULT 'medium',
    "animationSpeed" TEXT NOT NULL DEFAULT 'normal',
    "autoOpen" BOOLEAN NOT NULL DEFAULT false,
    "showOnScroll" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agent_widget_settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_widget_settings_agentId_key" ON "agent_widget_settings"("agentId");

-- AddForeignKey
ALTER TABLE "agent_widget_settings" ADD CONSTRAINT "agent_widget_settings_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

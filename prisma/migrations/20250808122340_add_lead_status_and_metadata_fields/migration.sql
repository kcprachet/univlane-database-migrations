-- CreateEnum
CREATE TYPE "LeadStatus" AS ENUM ('new', 'in_progress', 'submitted', 'closed');

-- CreateEnum
CREATE TYPE "LeadChannel" AS ENUM ('embed', 'playground', 'api');

-- AlterTable
ALTER TABLE "leads" ADD COLUMN     "channel" "LeadChannel" NOT NULL DEFAULT 'embed',
ADD COLUMN     "consent" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "consentAt" TIMESTAMP(3),
ADD COLUMN     "initialMessage" TEXT,
ADD COLUMN     "leadSource" TEXT,
ADD COLUMN     "metadata" JSONB,
ADD COLUMN     "status" "LeadStatus" NOT NULL DEFAULT 'new',
ADD COLUMN     "utmCampaign" TEXT,
ADD COLUMN     "utmMedium" TEXT,
ADD COLUMN     "utmSource" TEXT;

-- CreateIndex
CREATE INDEX "leads_status_idx" ON "leads"("status");

-- CreateIndex
CREATE INDEX "leads_channel_idx" ON "leads"("channel");

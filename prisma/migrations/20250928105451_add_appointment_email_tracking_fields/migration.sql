/*
  Warnings:

  - You are about to drop the `agent_lead_settings` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."agent_lead_settings" DROP CONSTRAINT "agent_lead_settings_agentId_fkey";

-- AlterTable
ALTER TABLE "public"."appointments" ADD COLUMN     "cancellation_reason" TEXT,
ADD COLUMN     "cancelled_at" TIMESTAMP(3),
ADD COLUMN     "reminder_sent_at" TIMESTAMP(3),
ADD COLUMN     "reschedule_reason" TEXT,
ADD COLUMN     "rescheduled_at" TIMESTAMP(3);

-- DropTable
DROP TABLE "public"."agent_lead_settings";

-- CreateIndex
CREATE INDEX "appointments_reminder_sent_at_idx" ON "public"."appointments"("reminder_sent_at");

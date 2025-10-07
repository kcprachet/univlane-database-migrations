-- AlterTable
ALTER TABLE "lead_flow_states" ADD COLUMN     "collectedData" JSONB,
ADD COLUMN     "currentQuestionId" TEXT;

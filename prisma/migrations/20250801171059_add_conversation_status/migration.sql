-- AlterTable
ALTER TABLE "conversations" ADD COLUMN     "status" TEXT NOT NULL DEFAULT 'active';

-- CreateIndex
CREATE INDEX "conversations_status_idx" ON "conversations"("status");

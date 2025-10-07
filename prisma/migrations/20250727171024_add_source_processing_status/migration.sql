-- AlterTable
ALTER TABLE "document_chunks" ALTER COLUMN "updatedAt" DROP DEFAULT;

-- AlterTable
ALTER TABLE "sources" ADD COLUMN     "processingCompletedAt" TIMESTAMP(3),
ADD COLUMN     "processingDetails" JSONB,
ADD COLUMN     "processingError" TEXT,
ADD COLUMN     "processingProgress" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "processingStartedAt" TIMESTAMP(3),
ADD COLUMN     "processingStatus" TEXT NOT NULL DEFAULT 'pending';

-- CreateIndex
CREATE INDEX "sources_processingStatus_idx" ON "sources"("processingStatus");

-- AlterTable
ALTER TABLE "public"."knowledge_gaps" ADD COLUMN     "instanceCount" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN     "instances" JSONB DEFAULT '[]';

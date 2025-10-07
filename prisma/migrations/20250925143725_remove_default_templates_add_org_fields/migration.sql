/*
  Warnings:

  - You are about to drop the `default_question_templates` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "public"."question_templates" ADD COLUMN     "description" TEXT,
ADD COLUMN     "is_active" BOOLEAN NOT NULL DEFAULT true;

-- DropTable
DROP TABLE "public"."default_question_templates";

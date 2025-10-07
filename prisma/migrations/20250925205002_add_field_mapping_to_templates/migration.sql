-- AlterTable
ALTER TABLE "public"."default_question_templates" ADD COLUMN     "field_mapping" TEXT;

-- AlterTable
ALTER TABLE "public"."question_templates" ADD COLUMN     "field_mapping" TEXT;

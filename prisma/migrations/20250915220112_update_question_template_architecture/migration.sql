-- Make org_id nullable for system templates
ALTER TABLE "public"."question_templates" ALTER COLUMN "org_id" DROP NOT NULL;

-- Drop the default_question_templates table as it's no longer needed
DROP TABLE IF EXISTS "public"."default_question_templates";

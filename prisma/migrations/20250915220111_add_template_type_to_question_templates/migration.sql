-- Add template_type column to question_templates table
ALTER TABLE "public"."question_templates" ADD COLUMN "template_type" TEXT NOT NULL DEFAULT 'user';
